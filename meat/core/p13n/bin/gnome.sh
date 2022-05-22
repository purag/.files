#!/bin/bash

profile=$(gsettings get org.gnome.Terminal.ProfilesList list | tr -d \'[])
dconf write "/org/gnome/terminal/legacy/profiles:/:$profile/palette" "[
  '#222231313A3A',
  '#EBEB36363131',
  '#9191C8C85A5A',
  '#FDFDBDBD4141',
  '#5F5F9F9FD4D4',
  '#F4F454547171',
  '#2424C5C5F3F3',
  '#FEFEFFFFFFFF',
  '#4A4A54545C5C',
  '#B3B32E2E2b2b',
  '#6161A2A25656',
  '#F5F574742F2F',
  '#0D0D7C7CBBBB',
  '#C9C93B3B5555',
  '#2F2F6D6DF3F3',
  '#BCBCC9C9D1D1'
]"
dconf write "/org/gnome/terminal/legacy/profiles:/:$profile/background-color" "'#222231313A3A'"
dconf write "/org/gnome/terminal/legacy/profiles:/:$profile/highlight-background-color" "'#4A4A54545C5C'"
dconf write "/org/gnome/terminal/legacy/profiles:/:$profile/foreground-color" "'#BCBCC9C9D1D1'"
dconf write "/org/gnome/terminal/legacy/profiles:/:$profile/font" "'Fira Code Retina 11'"
