#ifndef _Uno_ctx_h
#define _Uno_ctx_h

#include <stdint.h>
#include <stdbool.h>
/* Clause SEES */
#include "Cards.h"

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */


/* Clause SETS */

/* Clause CONCRETE_VARIABLES */


/* Clause CONCRETE_CONSTANTS */
/* Basic constants */
#define Uno_ctx__PENALTY 2
#define Uno_ctx__N_PLAYERS 2
#define Uno_ctx__INI_CARDS 7
#define Uno_ctx__NUM_CARDS 54


/* Array and record constants */




extern const Cards__CARD_TYPE Uno_ctx__INITIAL_DECK_T[54];
extern const Cards__COLORS Uno_ctx__INITIAL_DECK_C[54];
extern void Uno_ctx__INITIALISATION(void);


#ifdef __cplusplus
}
#endif /* __cplusplus */


#endif /* _Uno_ctx_h */
