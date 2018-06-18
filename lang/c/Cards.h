#ifndef _Cards_h
#define _Cards_h

#include <stdint.h>
#include <stdbool.h>
#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */


/* Clause SETS */
typedef enum
{
    Cards__ZERO,
    Cards__ONE,
    Cards__TWO,
    Cards__THREE,
    Cards__FOUR,
    Cards__FIVE,
    Cards__SIX,
    Cards__SEVEN,
    Cards__EIGHT,
    Cards__NINE,
    Cards__PLUS_TWO,
    Cards__BLOCK,
    Cards__SWITCH,
    Cards__PLUS_FOUR,
    Cards__JOKER
    
} Cards__CARD_TYPE;
typedef enum
{
    Cards__RED,
    Cards__GREEN,
    Cards__BLUE,
    Cards__YELLOW,
    Cards__BLACK
    
} Cards__COLORS;

/* Clause CONCRETE_VARIABLES */


/* Clause CONCRETE_CONSTANTS */
/* Basic constants */
/* Array and record constants */
extern void Cards__INITIALISATION(void);


#ifdef __cplusplus
}
#endif /* __cplusplus */


#endif /* _Cards_h */
