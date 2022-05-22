#!/bin/bash

profile=$(gsettings get org.gnome.Terminal.ProfilesList list | tr -d \'[])
dconf write "/org/gnome/terminal/legacy/profiles:/:$profile/palette" "[
  '#1A1A25252C2C',
  '#E3E31E1E2626',
  '#8181C1C14949',
  '#FCFCB1B13333',
  '#4F4F8D8DCACA',
  '#EFEF3B3B5F5F',
  '#2525B9B9F0F0',
  '#FFFFFFFFFFFF',
  '#3A3A43434A4A',
  '#A2A21D1D2121',
  '#515194944545',
  '#F0F05E5E2525',
  '#12126767ADAD',
  '#BBBB26264444',
  '#25255353F0F0',
  '#AFAFBEBEC7C7'
]"
dconf write "/org/gnome/terminal/legacy/profiles:/:$profile/background-color" "'#1A1A25252C2C'"
dconf write "/org/gnome/terminal/legacy/profiles:/:$profile/highlight-background-color" "'#3A3A43434A4A'"
dconf write "/org/gnome/terminal/legacy/profiles:/:$profile/foreground-color" "'#AFAFBEBEC7C7'"
dconf write "/org/gnome/terminal/legacy/profiles:/:$profile/font" "'Fira Mono Medium 11'"
