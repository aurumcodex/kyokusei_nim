#include <tonc.h>
#include "text.h"

// void write_data(u32 dataID)
// {
//     //TODO: add stuff here.
// }

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