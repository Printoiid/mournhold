// Include statements
#include QMK_KEYBOARD_H
#include <stdbool.h>
#include <stdint.h>

// This is used later in the OLED Screensaver
bool oled_screensaver_active = false;

// Animation timer/frames
#define FRAME_DURATION 75
uint32_t timer = 0;
uint8_t current_frame = 0;

// Import the stuff you need *after* defining globals... Duh
#include "triforce.h"
#include "ivy.h"

// Current KB Layers and their names
enum sofle_layers {
    _BASE,
    _FUNC,
    _CHARACTERS,
    _NUMPAD,
    _GAMES,
    _BLENDER,
    _BLENDNUM,
    _BLENDCMD,
    _LAYERSWITCH,
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
/* Base
 * ,-----------------------------------------.                     ,-----------------------------------------.
 * | ESC    | 1   | 2    | 3    | 4    | 5   |                     | 6    | 7    | 8    | 9    | 0    | - _  |
 * |--------+-----+------+------+------+-----|                     |------+------+------+------+------+------|
 * | Tab    | Q   | W    | E    | R    | T   |                     | Y    | U    | I    | O    | P    | \ |  |
 * |--------+-----+------+------+------+-----|                     |------+------+------+------+------+------|
 * | LShift | A   | S    | D    | F    | G   |--------.    ,-------| H    | J    | K    | L    | ; :  | ' "  |
 * |--------+-----+------+------+------+-----| Mute   |    | P/P   |------+------+------+------+------+------|
 * | LCTRL  | Z   | X    | C    | V    | B   |--------|    |-------| N    | M    | = +  | , <  | . >  | / ?  |
 * `-----------------------------------------/       /      \      \-----------------------------------------'
 *         | LGUI | LAlt | MO 1 | Backspc | / Enter /        \ MO 3 \  | Space | MO 2 |      | MO 3 |
 *         |      |      |      |         |/       /          \      \ |       |      |      |      |
 *         '------------------------------''------'            '------''----------------------------'       */
[_BASE] = LAYOUT(
  KC_ESC,  KC_1, KC_2,    KC_3,    KC_4,      KC_5,                                  KC_6,     KC_7,            KC_8,     KC_9,             KC_0,    KC_MINS,
  KC_TAB,  KC_Q, KC_W,    KC_E,    KC_R,      KC_T,                                  KC_Y,     KC_U,            KC_I,     KC_O,             KC_P,    KC_BSLS,
  KC_LSFT, KC_A, KC_S,    KC_D,    KC_F,      KC_G,                                  KC_H,     KC_J,            KC_K,     KC_L,             KC_SCLN, KC_QUOT,
  KC_LCTL, KC_Z, KC_X,    KC_C,    KC_V,      KC_B,         KC_MUTE,    KC_MPLY,     KC_N,     KC_M,            KC_EQUAL, KC_COMMA,         KC_DOT,  KC_SLSH,
                 KC_LGUI, KC_LALT, MO(_FUNC), KC_BACKSPACE, KC_ENT,     MO(_NUMPAD), KC_SPACE, MO(_CHARACTERS), XXXXXXX,  MO(_LAYERSWITCH)
),
/* Function
 * ,------------------------------------------.                    ,---------------------------------------------.
 * | F1    | F2   | F3   | F4   | F5   | F6   |                    |      |       |      |      |       | ALT-F4 |
 * |-------+------+------+------+------+------|                    |------+-------+------+------+-------+--------|
 * | F7    | F8   | F9   | F10  | F11  | F12  |                    |      |       |      |      |       |        |
 * |-------+------+------+------+------+------|                    |------+-------+------+------+-------+--------|
 * | CAPS  |      |      |      |      |      |-------.    ,-------|      |       |      |      |       |        |
 * |-------+------+------+------+------+------|       |    |       |------+-------+------+------+-------+--------|
 * | CTRL  | ALT  |      |      |      |      |-------|    |-------|      |       |      |      |       |        |
 * `------------------------------------------/      /      \      \---------------------------------------------'
 *            |       |      |      | PT   | / PT   /        \      \  |      | CTRL | ALT  | DEL  |
 *            |       |      |      |      |/      /          \      \ |      |      |      |      |
 *            '----------------------------''-----'            '------''---------------------------'            */
[_FUNC] = LAYOUT(
  KC_F1,   KC_F2,   KC_F3,   KC_F4,    KC_F5,   KC_F6,                         XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, LALT(KC_F4),
  KC_F7,   KC_F8,   KC_F9,   KC_F10,   KC_F11,  KC_F12,                        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  KC_CAPS, XXXXXXX, XXXXXXX, XXXXXXX,  XXXXXXX, XXXXXXX,                       XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  KC_LCTL, KC_LALT, XXXXXXX, XXXXXXX,  XXXXXXX, XXXXXXX, XXXXXXX,     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
                    XXXXXXX, XXXXXXX,  XXXXXXX, XXXXXXX, XXXXXXX,     XXXXXXX, XXXXXXX, KC_LCTL, KC_RALT, KC_DEL
),
/* Numpad
 * ,------------------------------------------.                     ,-------------------------------------------.
 * | PT   |      |      |      |      |       |                     |       | NLOCK | /    | *    |      |      |
 * |------+------+------+------+------+-------|                     |-------+-------+------+------+------+------|
 * | PT   |      |      |      |      |       |                     |       | 7     | 8    | 9    | -    |      |
 * |------+------+------+------+------+-------|                     |-------+-------+------+------+------+------|
 * | PT   |      |      |      |      |       |--------.    ,-------| DEL   | 4     | 5    | 6    | +    |      |
 * |------+------+------+------+------+-------| TOGRGB |    |       |-------+-------+------+------+------+------|
 * | PT   |      |      |      |      |       |--------|    |-------|       | 1     | 2    | 3    |      |      |
 * `------------------------------------------/       /      \      \-------------------------------------------'
 *            | PT   | PT   |      | Space | / BKSPC /        \      \  | ENTER | 0    | .    |      |
 *            |      |      |      |       |/       /          \      \ |       |      |      |      |
 *            '----------------------------''------'            '------''----------------------------'        */
[_NUMPAD] = LAYOUT(
  KC_TRNS, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                         XXXXXXX, KC_NUM,  KC_PSLS, KC_PAST, XXXXXXX, XXXXXXX,
  KC_TRNS, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                         XXXXXXX, KC_P7,   KC_P8,   KC_P9,   KC_PMNS, XXXXXXX,
  KC_TRNS, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                         KC_DEL,  KC_P4,   KC_P5,   KC_P6,   KC_PPLS, XXXXXXX,
  KC_TRNS, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,  UG_TOGG,      XXXXXXX, XXXXXXX, KC_P1,   KC_P2,   KC_P3,   XXXXXXX, XXXXXXX,
                    KC_TRNS, KC_TRNS, XXXXXXX, KC_SPACE, KC_BACKSPACE, XXXXXXX, KC_ENT,  KC_P0,   KC_PDOT, XXXXXXX 
),
/* Characters
 * ,-----------------------------------------.                    ,-------------------------------------------.
 * |      |      |      | [    | ]    | *    |                    |       |      |      |       |      |      |
 * |------+------+------+------+------+------|                    |-------+------+------+-------+------+------|
 * | `    | '    | "    | (    | )    | +    |                    |       |      | Up   |       | PGUP |      |
 * |------+------+------+------+------+------|                    |-------+------+------+-------+------+------|
 * | PT   | ~    | $    | {    | }    | -    |--------.   ,-------| DEL   | Left | Down | Right | PGDN | |    |
 * |------+------+------+------+------+------|        |   |       |-------+------+------+-------+------+------|
 * | PT   | :    | @    | <    | >    | =    |--------|   |-------|       |      |      |       |      |      |
 * `-----------------------------------------/       /     \      \-------------------------------------------'
 *            | PT   | PT   |      | PT   | / PT    /       \      \  |      |      |       |       |
 *            |      |      |      |      |/       /         \      \ |      |      |       |       |
 *            '-----------------------------------'           '------''-----------------------------'         */
[_CHARACTERS] = LAYOUT(
   XXXXXXX, XXXXXXX, XXXXXXX, KC_LBRC, KC_RBRC, KC_ASTR,                     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,  XXXXXXX, XXXXXXX,
   KC_GRV,  KC_QUOT, KC_DQT,  KC_LPRN, KC_RPRN, KC_PLUS,                     XXXXXXX, XXXXXXX, KC_UP,   XXXXXXX,  KC_PGUP, XXXXXXX,
   KC_TRNS, KC_TILD, KC_DLR,  KC_LCBR, KC_RCBR, KC_MINS,                     KC_DEL,  KC_LEFT, KC_DOWN, KC_RIGHT, KC_PGDN, KC_PIPE,
   KC_TRNS, KC_COLN, KC_AT,   KC_LABK, KC_RABK, KC_EQUAL, XXXXXXX,  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,  XXXXXXX, XXXXXXX,
                     KC_TRNS, KC_TRNS, XXXXXXX, KC_TRNS,  KC_TRNS,  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX
),
/* GAMES
 * ,-----------------------------------------.                     ,-----------------------------------------.
 * | ESC    | 1   | 2    | 3    | 4    | 5   |                     | 6    | 7    | 8    | 9    | 0    | - _  |
 * |--------+-----+------+------+------+-----|                     |------+------+------+------+------+------|
 * | Tab    | Q   | W    | E    | R    | T   |                     | Y    | U    | I    | O    | P    | \ |  |
 * |--------+-----+------+------+------+-----|                     |------+------+------+------+------+------|
 * | LShift | A   | S    | D    | F    | G   |--------.    ,-------| H    | J    | K    | L    | ; :  | ' "  |
 * |--------+-----+------+------+------+-----| Mute   |    | P/P   |------+------+------+------+------+------|
 * | LCTRL  | Z   | X    | C    | V    | B   |--------|    |-------| N    | M    | = +  | , <  | . >  | / ?  |
 * `-----------------------------------------/       /      \      \-----------------------------------------'
 *         |      | LAlt |      | SPC     | / BKSPC /        \ ENT  \  | Space |      |      | SWCH |
 *         |      |      |      |         |/       /          \      \ |       |      |      |      |
 *         '------------------------------''------'            '------''----------------------------'       */
[_GAMES] = LAYOUT(
  KC_ESC,  KC_1, KC_2,    KC_3,    KC_4,    KC_5,                             KC_6,      KC_7,    KC_8,     KC_9,            KC_0,    KC_MINS,
  KC_TAB,  KC_Q, KC_W,    KC_E,    KC_R,    KC_T,                             KC_Y,      KC_U,    KC_I,     KC_O,            KC_P,    KC_BSLS,
  KC_LSFT, KC_A, KC_S,    KC_D,    KC_F,    KC_G,                             KC_H,      KC_J,    KC_K,     KC_L,            KC_SCLN, KC_QUOT,
  KC_LCTL, KC_Z, KC_X,    KC_C,    KC_V,    KC_B,     KC_MUTE,      KC_MPLY,  KC_N,      KC_M,    KC_EQUAL, KC_COMMA,        KC_DOT,  KC_SLSH,
                 XXXXXXX, KC_LALT, XXXXXXX, KC_SPACE, KC_BACKSPACE, KC_ENTER, KC_SPACE,  XXXXXXX, XXXXXXX,  MO(_LAYERSWITCH)
),
/* Blender
 * ,-----------------------------------------.                     ,-----------------------------------------.
 * | ESC    | 1   | 2    | 3    | 4    | 5   |                     | 6    | 7    | 8    | 9    | 0    | - _  |
 * |--------+-----+------+------+------+-----|                     |------+------+------+------+------+------|
 * | Tab    | Q   | W    | E    | R    | T   |                     | Y    | U    | I    | O    | P    | \ |  |
 * |--------+-----+------+------+------+-----|                     |------+------+------+------+------+------|
 * | LShift | A   | S    | D    | F    | G   |--------.    ,-------| H    | J    | K    | L    | ; :  | ' "  |
 * |--------+-----+------+------+------+-----| Mute   |    | P/P   |------+------+------+------+------+------|
 * | LCTRL  | Z   | X    | C    | V    | B   |--------|    |-------| N    | M    | = +  | , <  | . >  | / ?  |
 * `-----------------------------------------/       /      \      \-----------------------------------------'
 *         | BLND | LAlt | BLND | Backspc | / Enter /        \      \  | Space |      |      | SWCH |
 *         | CMD  |      | NUM  |         |/       /          \      \ |       |      |      |      |
 *         '------------------------------''------'            '------''----------------------------'       */
[_BLENDER] = LAYOUT(
  KC_ESC,  KC_1, KC_2,          KC_3,    KC_4,          KC_5,                              KC_6,     KC_7,    KC_8,     KC_9,            KC_0,    KC_MINS,
  KC_TAB,  KC_Q, KC_W,          KC_E,    KC_R,          KC_T,                              KC_Y,     KC_U,    KC_I,     KC_O,            KC_P,    KC_BSLS,
  KC_LSFT, KC_A, KC_S,          KC_D,    KC_F,          KC_G,                              KC_H,     KC_J,    KC_K,     KC_L,            KC_SCLN, KC_QUOT,
  KC_LCTL, KC_Z, KC_X,          KC_C,    KC_V,          KC_B,         KC_MUTE,    KC_MPLY, KC_N,     KC_M,    KC_EQUAL, KC_COMMA,        KC_DOT,  KC_SLSH,
                 MO(_BLENDCMD), KC_LALT, MO(_BLENDNUM), KC_BACKSPACE, KC_ENT,     XXXXXXX, KC_SPACE, XXXXXXX, XXXXXXX,  MO(_LAYERSWITCH)
),
/* Blender Numpad
 * ,------------------------------------------.                    ,---------------------------------------------.
 * | DEL  | NLOCK | /    | *    | -    |      |                    |      |       |      |      |       |        |
 * |------+-------+------+------+------+------|                    |------+-------+------+------+-------+--------|
 * | TAB  | 7     | 8    | 9    | +    |      |                    |      |       |      |      |       |        |
 * |------+-------+------+------+------+------|                    |------+-------+------+------+-------+--------|
 * |      | 4     | 5    | 6    |      |      |-------.    ,-------|      |       |      |      |       |        |
 * |------+-------+------+------+------+------|       |    |       |------+-------+------+------+-------+--------|
 * |      | 1     | 2    | 3    |      |      |-------|    |-------|      |       |      |      |       |        |
 * `------------------------------------------/      /      \      \---------------------------------------------'
 *            |  0    | .    |      | PT   | / PT   /        \      \  |      |      |      |      |
 *            |       |      |      |      |/      /          \      \ |      |      |      |      |
 *            '-----------------------------------'            '------''---------------------------'            */
[_BLENDNUM] = LAYOUT(
  KC_DEL,  KC_NUM, KC_PSLS, KC_PAST, KC_PMNS, XXXXXXX,                       XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  KC_TAB,  KC_P7,  KC_P8,   KC_P9,   KC_PPLS, XXXXXXX,                       XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  XXXXXXX, KC_P4,  KC_P5,   KC_P6,   XXXXXXX, XXXXXXX,                       XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  XXXXXXX, KC_P1,  KC_P2,   KC_P3,   XXXXXXX, XXXXXXX, XXXXXXX,     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
                   KC_P0,   KC_PDOT, XXXXXXX, KC_TRNS, KC_TRNS,     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX
),
/* Blender Commands
 * ,-----------------------------------------.                     ,-----------------------------------------.
 * |      |      |      |      |      |      |                     |      |      |      |      |      |      |
 * |------+------+------+------+------+------|                     |------+------+------+------+------+------|
 * |      |      |      |      |      |      |                     |      |      |      |      |      |      |
 * |------+------+------+------+------+------|                     |------+------+------+------+------+------|
 * |      | Z    | X    | Y    |      |      |--------.    ,-------|      |      |      |      |      |      |
 * |------+------+------+------+------+------|        |    |       |------+------+------+------+------+------|
 * |      |      |      |      |      |      |--------|    |-------|      |      |      |      |      |      |
 * `-----------------------------------------/       /      \      \-----------------------------------------'
 *            |      |      |      |      | /       /        \      \  |      |      |      |      |
 *            |      |      |      |      |/       /          \      \ |      |      |      |      |
 *            '---------------------------''------'            '------''---------------------------'        */
[_BLENDCMD] = LAYOUT(
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                       XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                       XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  XXXXXXX, KC_Z,    KC_X,    KC_Y,    XXXXXXX, XXXXXXX,                       XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
                    XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX
),
/* LayerSwitch
 * ,------------------------------------------.                     ,-----------------------------------------.
 * |       |      |      |      |      |      |                     |      |      |      |      |      | BASE |
 * |-------+------+------+------+------+------|                     |------+------+------+------+------+------|
 * |       |      |      |      |      |      |                     |      |      |      |      |      | BNDR |
 * |-------+------+------+------+------+------|                     |------+------+------+------+------+------|
 * |       |      |      |      |      |      |--------.    ,-------|      |      |      |      |      |      |
 * |-------+------+------+------+------+------|        |    |       |------+------+------+------+------+------|
 * |       |      |      |      |      |      |--------|    |-------|      |      |      |      |      | GAME |
 * `------------------------------------------/       /      \      \-----------------------------------------'
 *             |      |      |      |      | /       /        \      \  |      |      |      |      |
 *             |      |      |      |      |/       /          \      \ |      |      |      |      |
 *             '---------------------------''------'            '------''---------------------------'        */
[_LAYERSWITCH] = LAYOUT(
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                       XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, TO(_BASE),
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                       XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, TO(_BLENDER),
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                       XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, TO(_GAMES),
                    XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX
)
};
/* Template layout
 * ,-----------------------------------------.                     ,-----------------------------------------.
 * |      |      |      |      |      |      |                     |      |      |      |      |      |      |
 * |------+------+------+------+------+------|                     |------+------+------+------+------+------|
 * |      |      |      |      |      |      |                     |      |      |      |      |      |      |
 * |------+------+------+------+------+------|                     |------+------+------+------+------+------|
 * |      |      |      |      |      |      |--------.    ,-------|      |      |      |      |      |      |
 * |------+------+------+------+------+------|        |    |       |------+------+------+------+------+------|
 * |      |      |      |      |      |      |--------|    |-------|      |      |      |      |      |      |
 * `-----------------------------------------/       /      \      \-----------------------------------------'
 *            |      |      |      |      | /       /        \      \  |      |      |      |      |
 *            |      |      |      |      |/       /          \      \ |      |      |      |      |
 *            '---------------------------''------'            '------''---------------------------'        */
/*
[_TEMPLATE] = LAYOUT(
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                       XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                       XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                       XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
                    XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,     XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX
),
*/

// Set the light mode when first powered on
void matrix_init_user() {
	rgblight_mode(5);
	rgblight_enable();
}

// Orients the non-master hand to display right-side-up
oled_rotation_t oled_init_user(oled_rotation_t rotation) {
    if (is_keyboard_master()) {
        return OLED_ROTATION_270;  // flips the display 270 degrees if mainhand
    } else {
        oled_clear();
        return OLED_ROTATION_270;  // flips the display 270 degrees if offhand
    }
    return rotation;
}

// This works now, just need a better animation.
bool oled_task_user(void) {
    // If the keyboard is active and screensaver is on, turn the OLED on and clear it once
    // This seems redundant, but it's added to reset the OLED after coming back from AFK
	if(last_input_activity_elapsed() < OLED_SCREENSAVER_TIMEOUT && oled_screensaver_active == true) {
        oled_screensaver_active = false;
        rgblight_enable();
        oled_on();
        oled_clear();
    }
	// Draw the layer information and change layer colors after and when the screensaver is disabled.
	if(last_input_activity_elapsed() < OLED_SCREENSAVER_TIMEOUT && oled_screensaver_active == false) {
        switch (get_highest_layer(layer_state)) {
            case _BASE:
                oled_write_P("-==-\nMain\nLayer\n-==-\n", false);
                rgblight_mode(11);
                rgblight_sethsv(127, 255, 255);
                break;
            case _FUNC:
                oled_write_P("-==-\nFunc\nLayer\n-==-\n", false);
                rgblight_mode(16);
                rgblight_sethsv(85, 255, 255);
                break;
            case _CHARACTERS:
                oled_write_P("-==-\nChar\nLayer\n-==-\n", false);
                rgblight_mode(1);
                rgblight_sethsv(190, 255, 255);
                break;
            case _NUMPAD:
                oled_write_P("-==-\nNum\nLayer\n-==-\n", false);
                rgblight_mode(11);
                rgblight_sethsv(148, 255, 255);
                break;
            case _GAMES:
                oled_write_P("-==-\nGame\nLayer\n-==-\n", false);
                rgblight_mode(26);
                rgblight_sethsv(200, 255, 255);
                break;
            case _BLENDER:
                oled_write_P("-==-\nBlnd\nLayer\n-==-\n", false);
                rgblight_mode(1);
                rgblight_sethsv(20, 255, 255);
                break;
            case _BLENDNUM:
                oled_write_P("-==-\nBNum\nLayer\n-==-\n", false);
                rgblight_mode(7);
                rgblight_sethsv(10, 255, 255);
                break;
            case _BLENDCMD:
                oled_write_P("-==-\nBcmd\nLayer\n-==-\n", false);
                rgblight_mode(7);
                rgblight_sethsv(15, 255, 255);
                break;
            case _LAYERSWITCH:
                oled_write_P("-==-\nSwch\nLayer\n-==-\n", false);
                rgblight_mode(20);
                rgblight_sethsv(1, 255, 255);
                break;
        }
		// Draw that silly little triforce animation
        triforce_animation();
    }
    // If the oled is on, but has been idle for longer than the screensaver time, turn the OLED off
    if(is_oled_on() && last_input_activity_elapsed() > OLED_TIMEOUT) {
        rgblight_disable();
        oled_clear();
        oled_off();
        oled_screensaver_active = false;
    // If the OLED is on, but has been idle for a while, turn the screensaver on
    } else if(is_oled_on() && last_input_activity_elapsed() > OLED_SCREENSAVER_TIMEOUT) {
        oled_screensaver_active = true;
        ivy_animation();
        rgblight_mode(5);
        rgblight_sethsv(150, 255, 255);
        return false;
    }
    return false;
}

bool encoder_update_kb(uint8_t index, bool clockwise) {
	
	if (!encoder_update_user(index, clockwise)) {
        return false;
    }
    // clockwise is technically counter clockwise, I'm too lazy to inverse it.
    switch (get_highest_layer(layer_state)) {
        case _BASE :
            if (index == 0) {
                if (clockwise) {
                    tap_code(KC_VOLU);
                } else {
                    tap_code(KC_VOLD);
                }
            } else if (index == 1) {
                if (clockwise) {
                    tap_code(KC_MNXT);
                } else {
                    tap_code(KC_MPRV);
                }
            }
            break;
        case _FUNC :
            if (index == 0) {
                if (clockwise) {
                    tap_code(KC_VOLU);
                } else {
                    tap_code(KC_VOLD);
                }
            } else if (index == 1) {
                if (clockwise) {
                    tap_code(KC_MNXT);
                } else {
                    tap_code(KC_MPRV);
                }
            }
            break;
        case _CHARACTERS :
            if (index == 0) {
                if (clockwise) {
                    tap_code(MS_WHLD);
                } else {
                    tap_code(MS_WHLU);
                }
            } else if (index == 1) {
                if (clockwise) {
                    tap_code(KC_MNXT);
                } else {
                    tap_code(KC_MPRV);
                }
            }
            break;
    }
    return true;
}
