/* WARNING if type checker is not performed, translation could contain errors ! */

#include "Uno.h"

/* Clause SEES */
#include "Cards.h"
#include "Uno_ctx.h"

/* Clause CONCRETE_CONSTANTS */
/* Basic constants */

/* Array and record constants */
/* Clause CONCRETE_VARIABLES */

static int32_t Uno__tc_i;
static Cards__COLORS Uno__tc_c;
static bool Uno__ideck[54];
static bool Uno__deck1[54];
static bool Uno__deck2[54];
static Cards__CARD_TYPE Uno__d_map_t[54];
static Cards__COLORS Uno__d_map_c[54];
static int32_t Uno__curr_player;
static bool Uno__said_uno;
static bool Uno__started;
static bool Uno__finished;
/* Clause INITIALISATION */
void Uno__INITIALISATION(void)
{
    
    unsigned int i = 0;
    Uno__tc_i = 0;
    Uno__tc_c = Uno_ctx__INITIAL_DECK_C[0];
    memmove(Uno__d_map_t,Uno_ctx__INITIAL_DECK_T,54 * sizeof(Cards__CARD_TYPE));
    memmove(Uno__d_map_c,Uno_ctx__INITIAL_DECK_C,54 * sizeof(Cards__COLORS));
    for(i = 0; i <= 53;i++)
    {
        Uno__ideck[i] = true;
    }
    for(i = 0; i <= 53;i++)
    {
        Uno__deck1[i] = false;
    }
    for(i = 0; i <= 53;i++)
    {
        Uno__deck2[i] = false;
    }
    Uno__curr_player = 0;
    Uno__said_uno = false;
    Uno__started = false;
    Uno__finished = false;
}

/* Clause OPERATIONS */

void Uno__get_top_card_type(Cards__CARD_TYPE *cc)
{
    (*cc) = Uno__d_map_t[Uno__tc_i];
}

void Uno__get_top_card_color(Cards__COLORS *cc)
{
    (*cc) = Uno__tc_c;
}

void Uno__draw_card(void)
{
    {
        int32_t idx;
        
        idx = 0;
        {
            int32_t ii;
            bool sw;
            
            ii = 0;
            sw = false;
            while(((ii) < (Uno_ctx__NUM_CARDS)) &&
            (sw == false))
            {
                {
                    bool res;
                    
                    res = Uno__ideck[ii];
                    if(res == true)
                    {
                        idx = ii;
                        Uno__ideck[ii] = false;
                        sw = true;
                    }
                }
                ii = ii+1;
            }
        }
        if(Uno__curr_player == 0)
        {
            Uno__deck1[idx] = true;
        }
        else
        {
            Uno__deck2[idx] = true;
        }
        {
            Cards__CARD_TYPE tt;
            Cards__COLORS cc;
            
            tt = Uno__d_map_t[idx];
            cc = Uno__d_map_c[idx];
            {
                Cards__CARD_TYPE tc_tp;
                
                tc_tp = Uno__d_map_t[Uno__tc_i];
                if(((((((tt) != (Cards__JOKER)) &&
                                ((tt) != (Cards__PLUS_FOUR)))) &&
                        ((cc) != (Cards__BLACK))) &&
                    ((tt) != (tc_tp))) &&
                ((cc) != (Uno__tc_c)))
                {
                    Uno__curr_player = (Uno__curr_player+1) % Uno_ctx__N_PLAYERS;
                }
            }
        }
    }
}

void Uno__say_uno(void)
{
    Uno__said_uno = true;
}

void Uno__play_card(Cards__CARD_TYPE tt, Cards__COLORS cc)
{
    {
        int32_t ii;
        bool sw;
        
        ii = 0;
        sw = false;
        while(((ii) < (Uno_ctx__NUM_CARDS)) &&
        (sw == false))
        {
            {
                Cards__CARD_TYPE res1;
                Cards__COLORS res2;
                
                res1 = Uno__d_map_t[ii];
                res2 = Uno__d_map_c[ii];
                if((res1 == tt) &&
                ((((((((tt) != (Cards__JOKER)) &&
                                        ((tt) != (Cards__PLUS_FOUR)))) &&
                                (res2 == cc))) ||
                        (((((tt == Cards__JOKER) ||
                                        (tt == Cards__PLUS_FOUR))) &&
                                (res2 == Cards__BLACK))))))
                {
                    Uno__tc_i = ii;
                    Uno__tc_c = cc;
                    if(Uno__curr_player == 0)
                    {
                        Uno__deck1[Uno__tc_i] = false;
                    }
                    else
                    {
                        Uno__deck2[Uno__tc_i] = false;
                    }
                    sw = true;
                }
            }
            ii = ii+1;
        }
    }
    if(Uno__curr_player == 0)
    {
        {
            int32_t ii;
            int32_t count;
            
            ii = 0;
            count = 0;
            while((ii) < (Uno_ctx__NUM_CARDS))
            {
                {
                    bool res;
                    
                    res = Uno__deck1[ii];
                    if(res == true)
                    {
                        count = count+1;
                    }
                }
                ii = ii+1;
            }
            if((count == 1) &&
            (Uno__said_uno == false))
            {
                {
                    int32_t nc;
                    
                    ii = 0;
                    nc = 0;
                    while(((ii) < (Uno_ctx__NUM_CARDS)) &&
                    ((nc) < (Uno_ctx__PENALTY)))
                    {
                        {
                            bool res;
                            
                            res = Uno__ideck[ii];
                            if(res == true)
                            {
                                Uno__ideck[ii] = false;
                                Uno__deck1[ii] = true;
                                nc = nc+1;
                            }
                        }
                    }
                }
            }
        }
    }
    else
    {
        {
            int32_t ii;
            int32_t count;
            
            ii = 0;
            count = 0;
            while((ii) < (Uno_ctx__NUM_CARDS))
            {
                {
                    bool res;
                    
                    res = Uno__deck2[ii];
                    if(res == true)
                    {
                        count = count+1;
                    }
                }
                ii = ii+1;
            }
            if((count == 1) &&
            (Uno__said_uno == false))
            {
                {
                    int32_t nc;
                    
                    ii = 0;
                    nc = 0;
                    while(((ii) < (Uno_ctx__NUM_CARDS)) &&
                    ((nc) < (Uno_ctx__PENALTY)))
                    {
                        {
                            bool res;
                            
                            res = Uno__ideck[ii];
                            if(res == true)
                            {
                                Uno__ideck[ii] = false;
                                Uno__deck2[ii] = true;
                                nc = nc+1;
                            }
                        }
                        ii = ii+1;
                    }
                }
            }
        }
    }
    {
        Cards__CARD_TYPE tc_tp;
        
        tc_tp = Uno__d_map_t[Uno__tc_i];
        if(tc_tp == Cards__PLUS_TWO)
        {
            if(Uno__curr_player == 0)
            {
                {
                    int32_t ii;
                    int32_t nc;
                    int32_t count;
                    
                    ii = 0;
                    nc = 0;
                    count = 0;
                    while(((ii) < (Uno_ctx__NUM_CARDS)) &&
                    ((nc) < (2)))
                    {
                        {
                            bool res;
                            bool res2;
                            
                            res = Uno__ideck[ii];
                            res2 = Uno__deck2[ii];
                            if(res == true)
                            {
                                Uno__ideck[ii] = false;
                                Uno__deck2[ii] = true;
                                nc = nc+1;
                            }
                            else if(res2 == true)
                            {
                                count = count+1;
                            }
                        }
                        ii = ii+1;
                    }
                }
            }
            else
            {
                {
                    int32_t ii;
                    int32_t nc;
                    int32_t count;
                    
                    ii = 0;
                    nc = 0;
                    count = 0;
                    while(((ii) < (Uno_ctx__NUM_CARDS)) &&
                    ((nc) < (2)))
                    {
                        {
                            bool res;
                            bool res2;
                            
                            res = Uno__ideck[ii];
                            res2 = Uno__deck1[ii];
                            if(res == true)
                            {
                                Uno__ideck[ii] = false;
                                Uno__deck1[ii] = true;
                                nc = nc+1;
                            }
                            else if(res2 == true)
                            {
                                count = count+1;
                            }
                        }
                        ii = ii+1;
                    }
                }
            }
        }
        else if(tc_tp == Cards__PLUS_FOUR)
        {
            if(Uno__curr_player == 0)
            {
                {
                    int32_t ii;
                    int32_t nc;
                    int32_t count;
                    
                    ii = 0;
                    nc = 0;
                    count = 0;
                    while(((ii) < (Uno_ctx__NUM_CARDS)) &&
                    ((nc) < (4)))
                    {
                        {
                            bool res;
                            bool res2;
                            
                            res = Uno__ideck[ii];
                            res2 = Uno__deck2[ii];
                            if(res == true)
                            {
                                Uno__ideck[ii] = false;
                                Uno__deck2[ii] = true;
                                nc = nc+1;
                            }
                            else if(res2 == true)
                            {
                                count = count+1;
                            }
                        }
                        ii = ii+1;
                    }
                }
            }
            else
            {
                {
                    int32_t ii;
                    int32_t nc;
                    int32_t count;
                    
                    ii = 0;
                    nc = 0;
                    count = 0;
                    while(((ii) < (Uno_ctx__NUM_CARDS)) &&
                    ((nc) < (4)))
                    {
                        {
                            bool res;
                            bool res2;
                            
                            res = Uno__ideck[ii];
                            res2 = Uno__deck1[ii];
                            if(res == true)
                            {
                                Uno__ideck[ii] = false;
                                Uno__deck1[ii] = true;
                                nc = nc+1;
                            }
                            else if(res2 == true)
                            {
                                count = count+1;
                            }
                        }
                        ii = ii+1;
                    }
                }
            }
        }
        else if((tc_tp) != (Cards__BLOCK))
        {
            Uno__curr_player = (Uno__curr_player+1) % Uno_ctx__N_PLAYERS;
        }
    }
    {
        int32_t count1;
        int32_t count2;
        int32_t ii;
        
        count1 = 0;
        count2 = 0;
        ii = 0;
        while((ii) < (Uno_ctx__NUM_CARDS))
        {
            {
                bool res1;
                bool res2;
                
                res1 = Uno__deck1[ii];
                res2 = Uno__deck2[ii];
                if(res1 == true)
                {
                    count1 = count1+1;
                }
                else if(res2 == true)
                {
                    count2 = count2+1;
                }
            }
            ii = ii+1;
        }
        if((count1 == 0) ||
        (count2 == 0))
        {
            Uno__finished = true;
        }
    }
    Uno__said_uno = false;
}

void Uno__start_game(void)
{
    unsigned int i = 0;
    {
        for(i = 0; i <= 53;i++)
        {
            Uno__ideck[i] = true;
        }
        for(i = 0; i <= 53;i++)
        {
            Uno__deck1[i] = false;
        }
        for(i = 0; i <= 53;i++)
        {
            Uno__deck2[i] = false;
        }
        Uno__tc_i = 0;
        Uno__tc_c = Uno__d_map_c[0];
        {
            int32_t ii;
            int32_t lst;
            
            ii = 1;
            lst = Uno_ctx__INI_CARDS+1;
            while((ii) < (lst))
            {
                Uno__deck1[ii] = true;
                Uno__ideck[ii] = false;
                ii = ii+1;
            }
            lst = 2 * Uno_ctx__INI_CARDS;
            while((ii) < (lst))
            {
                Uno__deck2[ii] = true;
                Uno__ideck[ii] = false;
                ii = ii+1;
            }
        }
        Uno__started = true;
        Uno__finished = false;
    }
}

void Uno__get_winner(int32_t *ww)
{
    int32_t ii;
    bool e1;
    
    ii = 0;
    e1 = true;
    while(((ii) < (Uno_ctx__NUM_CARDS)) &&
    (e1 == true))
    {
        {
            bool res;
            
            res = Uno__deck1[ii];
            if(res == true)
            {
                e1 = false;
            }
        }
        ii = ii+1;
    }
    if(e1 == true)
    {
        (*ww) = 0;
    }
    else
    {
        (*ww) = 1;
    }
}

