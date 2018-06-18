#ifndef _Uno_h
#define _Uno_h

#include <stdint.h>
#include <stdbool.h>
#include <string.h>
/* Clause SEES */
#include "Cards.h"
#include "Uno_ctx.h"

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */


/* Clause SETS */

/* Clause CONCRETE_VARIABLES */


/* Clause CONCRETE_CONSTANTS */
/* Basic constants */
/* Array and record constants */
extern void Uno__INITIALISATION(void);

/* Clause OPERATIONS */

extern void Uno__get_top_card_type(Cards__CARD_TYPE *cc);
extern void Uno__get_top_card_color(Cards__COLORS *cc);
extern void Uno__draw_card(void);
extern void Uno__say_uno(void);
extern void Uno__play_card(Cards__CARD_TYPE tt, Cards__COLORS cc);
extern void Uno__start_game(void);
extern void Uno__get_winner(int32_t *ww);

#ifdef __cplusplus
}
#endif /* __cplusplus */


#endif /* _Uno_h */
