/*
 *  text.c
 * 
 *  A file that gets "wrapped" by Nim so that functions declared here
 *  can be directly called in the Nim sources, and with minimal overhead.
 *  (This file is the one that gets compiled and linked.)
 */

#include <tonc.h>

#include "text.h"

/*
 *   print_score()
 *
 *   A function to assist in printing the score of the game.
 *   Needed due to using Nim in an embedded platform doesn't mean that a `copyStr`
 *   function will be available.
 */
void print_score(u32 score)
{
    // tte_set_margins(0, 0, SCREEN_WIDTH, 20);
    tte_erase_screen();
    // tte_set_drawg(chr4c_drawg_b4cts_fast);
    tte_printf("#{P:0,0}Score: %d", score);
}

void print_section(u32 submap)
{
    tte_erase_screen();
    switch (submap)
    {
        case 1:
            tte_printf("#{P:150,80}Section: One");
        case 2:
            tte_printf("#{P:150,80}Section: Two");
        // default:
            // tte_printf("#{P:150,80}Section: Other");
    }
}