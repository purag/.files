#!/bin/bash

export __black="$(tput setaf {{ colors.black.normal.code }})"
export __red="$(tput setaf {{ colors.red.normal.code }})"
export __green="$(tput setaf {{ colors.green.normal.code }})"
export __yellow="$(tput setaf {{ colors.yellow.normal.code }})"
export __blue="$(tput setaf {{ colors.blue.normal.code }})"
export __violet="$(tput setaf {{ colors.violet.normal.code }})"
export __cyan="$(tput setaf {{ colors.cyan.normal.code }})"
export __white="$(tput setaf {{ colors.white.normal.code }})"

export __bright_black="$(tput setaf {{ colors.black.bright.code }})"
export __bright_red="$(tput setaf {{ colors.red.bright.code }})"
export __bright_green="$(tput setaf {{ colors.green.bright.code }})"
export __bright_yellow="$(tput setaf {{ colors.yellow.bright.code }})"
export __bright_blue="$(tput setaf {{ colors.blue.bright.code }})"
export __bright_violet="$(tput setaf {{ colors.violet.bright.code }})"
export __bright_cyan="$(tput setaf {{ colors.cyan.bright.code }})"
export __bright_white="$(tput setaf {{ colors.white.bright.code }})"

# Aliases
export __orange=$__bright_yellow
export __dark_gray=$__bright_black
export __gray=$__bright_white
