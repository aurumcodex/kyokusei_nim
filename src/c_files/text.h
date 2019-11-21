/*
 *  text.h
 * 
 *  A file that gets "wrapped" by Nim so that functions declared here
 *  can be directly called in the Nim sources, and with minimal overhead.
 */

#include <tonc.h>

// ==== prototypes ===============================================
// documentation for this function can be found in `text.c`
void print_score(u32 score);

void print_section(u32 submap);