/*
 *  text.h
 * 
 *  A file that gets "wrapped" by Nim so that functions declared here
 *  can be directly called in the Nim sources, and with minimal overhead.
 */

#include <tonc.h>

// ==== prototypes ===============================================
// documentation for these functions can be found in `text.c`

void print_player_pos(s32 x, s32 y);

void print_score(u32 score);

void print_section(s32 submap);