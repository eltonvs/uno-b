/* WARNING if type checker is not performed, translation could contain errors ! */

#include "Uno_ctx.h"

/* Clause SEES */
#include "Cards.h"

/* Clause CONCRETE_CONSTANTS */
/* Basic constants */

#define Uno_ctx__PENALTY 2
#define Uno_ctx__N_PLAYERS 2
#define Uno_ctx__INI_CARDS 7
#define Uno_ctx__NUM_CARDS 54
/* Array and record constants */

const Cards__CARD_TYPE Uno_ctx__INITIAL_DECK_T[54] = {Cards__ZERO,Cards__ZERO,Cards__ZERO,Cards__ZERO,Cards__ONE,Cards__ONE,Cards__ONE,Cards__ONE,Cards__TWO,Cards__TWO,Cards__TWO,Cards__TWO,Cards__THREE,Cards__THREE,Cards__THREE,Cards__THREE,Cards__FOUR,Cards__FOUR,Cards__FOUR,Cards__FOUR,Cards__FIVE,Cards__FIVE,Cards__FIVE,Cards__FIVE,Cards__SIX,Cards__SIX,Cards__SIX,Cards__SIX,Cards__SEVEN,Cards__SEVEN,Cards__SEVEN,Cards__SEVEN,Cards__EIGHT,Cards__EIGHT,Cards__EIGHT,Cards__EIGHT,Cards__NINE,Cards__NINE,Cards__NINE,Cards__NINE,Cards__PLUS_TWO,Cards__PLUS_TWO,Cards__PLUS_TWO,Cards__PLUS_TWO,Cards__BLOCK,Cards__BLOCK,Cards__BLOCK,Cards__BLOCK,Cards__SWITCH,Cards__SWITCH,Cards__SWITCH,Cards__SWITCH,Cards__PLUS_FOUR,Cards__JOKER};

const Cards__COLORS Uno_ctx__INITIAL_DECK_C[54] = {Cards__RED,Cards__GREEN,Cards__BLUE,Cards__YELLOW,Cards__RED,Cards__GREEN,Cards__BLUE,Cards__YELLOW,Cards__RED,Cards__GREEN,Cards__BLUE,Cards__YELLOW,Cards__RED,Cards__GREEN,Cards__BLUE,Cards__YELLOW,Cards__RED,Cards__GREEN,Cards__BLUE,Cards__YELLOW,Cards__RED,Cards__GREEN,Cards__BLUE,Cards__YELLOW,Cards__RED,Cards__GREEN,Cards__BLUE,Cards__YELLOW,Cards__RED,Cards__GREEN,Cards__BLUE,Cards__YELLOW,Cards__RED,Cards__GREEN,Cards__BLUE,Cards__YELLOW,Cards__RED,Cards__GREEN,Cards__BLUE,Cards__YELLOW,Cards__RED,Cards__GREEN,Cards__BLUE,Cards__YELLOW,Cards__RED,Cards__GREEN,Cards__BLUE,Cards__YELLOW,Cards__RED,Cards__GREEN,Cards__BLUE,Cards__YELLOW,Cards__BLACK,Cards__BLACK};
/* Clause CONCRETE_VARIABLES */

/* Clause INITIALISATION */
void Uno_ctx__INITIALISATION(void)
{
    
    ;
}

