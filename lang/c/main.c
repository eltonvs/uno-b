#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Uno.h"
#include "Cards.h"

#define OP_GET_TOP_CARD_TYPE 1
#define OP_GET_TOP_CARD_COLOR 2
#define OP_START_GAME 3
#define OP_DRAW_CARD 4
#define OP_SAY_UNO 5
#define OP_PLAY_CARD 6
#define OP_GET_WINNER 7
#define OP_EXIT 8

void print_menu();
void do_play_card();
void print_card_type(Cards__CARD_TYPE);
void print_card_color(Cards__COLORS);

int main() {
    print_menu();

    // Call Initialisation
    Uno__INITIALISATION();
    Cards__INITIALISATION();
    Uno_ctx__INITIALISATION();

    char buf;
    bool run = true;
    int op;

    while (run) {
        printf(">>> ");
        scanf("%d", &op);
        Cards__CARD_TYPE card_type;
        Cards__COLORS card_color;
        int32_t player;

        switch (op) {
            case OP_GET_TOP_CARD_TYPE:
                Uno__get_top_card_type(&card_type);
                print_card_type(card_type);
                scanf("%c%c", &buf, &buf);
                break;
            case OP_GET_TOP_CARD_COLOR:
                Uno__get_top_card_color(&card_color);
                print_card_color(card_color);
                scanf("%c%c", &buf, &buf);
                break;
            case OP_START_GAME:
                Uno__start_game();
                break;
            case OP_DRAW_CARD:
                Uno__draw_card();
                break;
            case OP_SAY_UNO:
                Uno__say_uno();
                break;
            case OP_PLAY_CARD:
                do_play_card();
                break;
            case OP_GET_WINNER:
                Uno__get_winner(&player);
                printf("Player %i\n", player + 1);
                scanf("%c%c", &buf, &buf);
                break;
            case OP_EXIT:
                run = false;
                printf("Exiting...\n");
                continue;
            default:
                printf("Operation not supported. Try again\n");
                continue;
        }

        print_menu();
    }

    return EXIT_SUCCESS;
}

void print_card_type(Cards__CARD_TYPE ct) {
    switch (ct) {
        case Cards__ZERO:
            printf("Zero\n");
            break;
        case Cards__ONE:
            printf("One\n");
            break;
        case Cards__TWO:
            printf("Two\n");
            break;
        case Cards__THREE:
            printf("Three\n");
            break;
        case Cards__FOUR:
            printf("Four\n");
            break;
        case Cards__FIVE:
            printf("Five\n");
            break;
        case Cards__SIX:
            printf("Six\n");
            break;
        case Cards__SEVEN:
            printf("Seven\n");
            break;
        case Cards__EIGHT:
            printf("Eight\n");
            break;
        case Cards__NINE:
            printf("Nine\n");
            break;
        case Cards__PLUS_TWO:
            printf("Plus 2\n");
            break;
        case Cards__BLOCK:
            printf("Block\n");
            break;
        case Cards__SWITCH:
            printf("Switch\n");
            break;
        case Cards__PLUS_FOUR:
            printf("Plus 4\n");
            break;
        case Cards__JOKER:
            printf("Joker\n");
    }
}

void print_card_color(Cards__COLORS cc) {
    switch (cc) {
        case Cards__RED:
            printf("Red\n");
            break;
        case Cards__GREEN:
            printf("Green\n");
            break;
        case Cards__BLUE:
            printf("Blue\n");
            break;
        case Cards__YELLOW:
            printf("Yellow\n");
            break;
        case Cards__BLACK:
            printf("Black\n");
    }
}


void print_menu() {
    system("@cls || clear");
    printf("UNO-B -- Menu\n");
    printf("%2d. Get top card type\n", OP_GET_TOP_CARD_TYPE);
    printf("%2d. Get top card color\n", OP_GET_TOP_CARD_COLOR);
    printf("%2d. Start Game\n", OP_START_GAME);
    printf("%2d. Draw Card\n", OP_DRAW_CARD);
    printf("%2d. Say Uno\n", OP_SAY_UNO);
    printf("%2d. Play Card\n", OP_PLAY_CARD);
    printf("%2d. Get Winner\n", OP_GET_WINNER);
    printf("%2d. Exit\n", OP_EXIT);
    printf("\n");
}

void do_play_card() {
    system("@cls || clear");
    printf("Select Card Type\n");
    printf("%2d. ZERO\n", Cards__ZERO);
    printf("%2d. ONE\n", Cards__ONE);
    printf("%2d. TWO\n", Cards__TWO);
    printf("%2d. THREE\n", Cards__THREE);
    printf("%2d. FOUR\n", Cards__FOUR);
    printf("%2d. FIVE\n", Cards__FIVE);
    printf("%2d. SIX\n", Cards__SIX);
    printf("%2d. SEVEN\n", Cards__SEVEN);
    printf("%2d. EIGHT\n", Cards__EIGHT);
    printf("%2d. NINE\n", Cards__NINE);
    printf("%2d. PLUS_TWO\n", Cards__PLUS_TWO);
    printf("%2d. BLOCK\n", Cards__BLOCK);
    printf("%2d. SWITCH\n", Cards__SWITCH);
    printf("%2d. PLUS_FOUR\n", Cards__PLUS_FOUR);
    printf("%2d. JOKER\n", Cards__JOKER);
    printf("\n");

    int ct;

    do {
        printf(">>> ");
        scanf("%d", &ct);
    } while ((ct < 0) || (ct > 14));

    system("@cls || clear");
    printf("Select Card Color\n");
    printf("%2d. RED\n", Cards__RED);
    printf("%2d. GREEN\n", Cards__GREEN);
    printf("%2d. BLUE\n", Cards__BLUE);
    printf("%2d. YELLOW\n", Cards__YELLOW);
    printf("\n");

    int cc;

    do {
        printf(">>> ");
        scanf("%d", &cc);
    } while ((cc < 0) || (cc > 3));

    Cards__CARD_TYPE c_tp;
    Cards__COLORS c_cl;

    if (ct == 0) {
        c_tp = Cards__ZERO;
    } else if (ct == 0) {
        c_tp = Cards__ONE;
    } else if (ct == 0) {
        c_tp = Cards__TWO;
    } else if (ct == 0) {
        c_tp = Cards__THREE;
    } else if (ct == 0) {
        c_tp = Cards__FOUR;
    } else if (ct == 0) {
        c_tp = Cards__FIVE;
    } else if (ct == 0) {
        c_tp = Cards__SIX;
    } else if (ct == 0) {
        c_tp = Cards__SEVEN;
    } else if (ct == 0) {
        c_tp = Cards__EIGHT;
    } else if (ct == 0) {
        c_tp = Cards__NINE;
    } else if (ct == 0) {
        c_tp = Cards__PLUS_TWO;
    } else if (ct == 0) {
        c_tp = Cards__BLOCK;
    } else if (ct == 0) {
        c_tp = Cards__SWITCH;
    } else if (ct == 0) {
        c_tp = Cards__PLUS_FOUR;
    } else if (ct == 0) {
        c_tp = Cards__JOKER;
    }

    if (cc == 0) {
        c_cl = Cards__RED;
    } else if (cc == 0) {
        c_cl = Cards__GREEN;
    } else if (cc == 0) {
        c_cl = Cards__BLUE;
    } else if (cc == 0) {
        c_cl = Cards__YELLOW;
    }

    Uno__play_card(c_tp, c_cl);
}
