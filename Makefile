# ========== 極性 -Kyokusei- ============================= Makefile ============================== #
#            template from devkitARM examples, modified to suit library use                        #
# __________ current version: 0.1.0-20191106 _____________________________________________________ #

# ----------------------- suffix setting --------------------------------------------------------- #
.SUFFIXES:

# ----------------------- color escape codes ----------------------------------------------------- #
BLD_BLU 	:= $(shell printf "\033[1;34m")
BLD_GRN		:= $(shell printf "\033[1;32m")
BLD_PRP		:= $(shell printf "\033[1;35m")

# ----------------------- find devkitARM var ----------------------------------------------------- #
ifeq ($(strip $(DEVKITARM)),)
	$(error "DEVKITARM environment variable not found. Use export DEVKITARM=<path to>devkitARM")
endif

# ---------------------- include gba_rules & garphics_lib.mk ------------------------------------- #
include $(DEVKITARM)/gba_rules
# include ./gfx_make.mk

# ----------------------- set source directories ------------------------------------------------- #
TARGET		:= $(notdir $(CURDIR))
TARGETS		:= $(TARGET).elf $(TARGET).gba $(TARGET).sav
BUILD		:= build
SOURCES		:= C_source
INCLUDES	:= include
BIN_DATA	:=
AUDIO		:= audio
GRAPHICS	:= src/gfx
BOOK		:= book

# ----------------------- code gen options ------------------------------------------------------- #
ARCH		:= -mthumb -mthumb-interwork

CFLAGS		:= -g -Wall -O3 -mcpu=arm7tdmi -mtune=arm7tdmi $(ARCH)
CFLAGS		+= $(INCLUDE)

CXXFLAGS	:= $(CFLAGS) -fno-rtti -fno-exceptions

ASFLAGS		:= -g $(ARCH)
LDFLAGS		:= -g $(ARCH) -Wl,-Map,$(notdir $*.map)

# ----------------------- libraries and lib_dirs ------------------------------------------------- #
LIBS		:= -ltonc -lmm

LIBTONC		:= $(DEVKITPRO)/libtonc
LIBDIRS		:= $(LIBTONC) $(LIBGBA)
# LIBGFX		:= libgfx.a

# +++++++++++++++++++++++ build procedures +++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
ifneq ($(BUILD),$(notdir $(CURDIR)))

# ----------------------- file collecting -------------------------------------------------------- #
export OUTPUT	:=  $(CURDIR)/$(TARGET)
export VPATH	:=  $(foreach dir,$(SOURCES),$(CURDIR)/$(dir)) \
					$(foreach dir,$(BIN_DATA),$(CURDIR)/$(dir)) \
					$(foreach dir,$(GRAPHICS),$(CURDIR)/$(dir))
export DEPSDIR	:=  $(CURDIR)/$(BUILD)

CFILES			:=  $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.c)))
CPPFILES		:=  $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.cpp)))
SFILES			:=  $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.s)))
BINFILES		:=  $(foreach dir,$(BIN_DATA),$(notdir $(wildcard $(dir)/*.*)))

ifneq ($(strip $(AUDIO)),)
export AUDIOFILES	:= $(foreach dir,$(notdir $(wildcard $(AUDIO)/*.*)),$(CURDIR)/$(AUDIO)/$(dir))
BINFILES			+= soundbank.bin
endif

ifneq ($(strip $(BOOK)),)
BOOKSRC		:= $(BOOK)/src
export MDFILES	:=  $(foreach dir,$(notdir $(wildcard $(BOOKSRC)/*.md)),$(CURDIR)/$(BOOKSRC)/$(dir))
endif

# ----------------------- linking file preferences ----------------------------------------------- #
ifeq ($(strip $(CPPFILES)),)
	export LD	:= $(CC)
else
	export LD	:= $(CXX)
endif

# ----------------------- variable exports ------------------------------------------------------- #
export OFILES_BIN		:=  $(addsuffix .o,$(BINFILES))
export OFILES_SOURCES	:=  $(CPPFILES:.cpp=.o) $(CFILES:.c=.o) $(SFILES:.s=.o)
export OFILES			:=  $(OFILES_BIN) $(OFILES_SOURCES)
export HFILES			:=  $(addsuffix .h,$(subst .,_,$(BINFILES)))
export INCLUDE			:=  $(foreach dir,$(INCLUDES),-iquote $(CURDIR)/$(dir)) \
							$(foreach dir,$(LIBDIRS),-I$(dir)/include) \
							-I$(CURDIR)/$(BUILD)
export LIBPATHS			:=  $(foreach dir,$(LIBDIRS),-L$(dir)/lib)

# ----------------------- build targets ---------------------------------------------------------- #
.PHONY: $(BUILD) clean

all : $(BUILD)

$(BUILD):
	@[ -d $@ ] || mkdir -p $@
	@printf "\n$(BLD_PRP)::\033[0m \033[1;4mCompiling generated C files...\033[0m\n"
	@$(MAKE) --no-print-directory -C $(BUILD) -f $(CURDIR)/Makefile -s
	@printf "\n$(BLD_GRN)::\033[0m \033[1mkyokusei.gba created.\033[0m\n\n"

clean:
	@printf "\n$(BLD_BLU)::\033[0m \033[1mcleaning files...\033[0m\n\n"
	@rm -rfv $(BUILD) $(TARGETS) guidebook.pdf $(SOURCES) $(GRAPHICS)/*.bin
	@printf "\n$(BLD_GRN)::\033[0m \033[1mproject cleaned.\033[0m\n\n"

else

DEPENDS 	:= $(OFILES:.o=.d)
# ----------------------- main targets ----------------------------------------------------------- #
$(OUTPUT).gba	  :	$(OUTPUT).elf

$(OUTPUT).elf	  :	$(OFILES)

$(OFILES_SOURCES) : $(HFILES)

# ----------------------- soundbank generation --------------------------------------------------- #
soundbank.bin soundbank.h : $(AUDIOFILES)
	@mmutil $^ -osoundbank.bin -hsoundbank.h

# ----------------------- binary data linking ---------------------------------------------------- #
%.bin.o %_bin.h : %.bin
	@printf "$(notdir $<)\n"
	@$(bin2o)

-include $(DEPSDIR)/*.d
endif
# ======================= EOF ==================================================================== #