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
void print_player_pos(s32 x, s32 y)
{
    tte_erase_screen();
    tte_printf("#{P:120,0}x: %d; y: %d", x, y);
}

/*
 *   print_score()
 *
 *   A function to assist in printing the score of the game.
 *   Needed due to using Nim in an embedded platform doesn't mean that a `copyStr`
 *   function will be available.
 */
void print_score(u32 score)
{
    tte_erase_screen();
    tte_printf("#{P:0,0}Score: %d", score);
}

/*
 *   print_section()
 *
 *   A function to assist in printing the section of the map of the game.
 *   Used mainly for debugging purposes.
 */
void print_section(s32 submap)
{
    tte_erase_screen();
    switch (submap)
    {
        case 1:
            tte_printf("#{P:150,80}Section: One");
            break;
        case 2:
            tte_printf("#{P:150,80}Section: Two");
            break;
        case 3:
            tte_printf("#{P:150,80}Section: Three");
            break;
        case 4:
            tte_printf("#{P:150,80}Section: Four");
            break;
        case 5:
            tte_printf("#{P:150,80}Section: Five");
            break;
        case 6:
            tte_printf("#{P:150,80}Section: Six");
            break;
        default:
            tte_printf("#{P:150,80}Section: Unknown");
            break;
    }
}