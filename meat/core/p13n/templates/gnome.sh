#!/bin/bash

profile=$(gsettings get org.gnome.Terminal.ProfilesList list | tr -d \'[])
dconf write "/org/gnome/terminal/legacy/profiles:/:$profile/palette" "[
  '{{ colors.black.normal.hex | to_gnome_color }}',
  '{{ colors.red.normal.hex | to_gnome_color }}',
  '{{ colors.green.normal.hex | to_gnome_color }}',
  '{{ colors.yellow.normal.hex | to_gnome_color }}',
  '{{ colors.blue.normal.hex | to_gnome_color }}',
  '{{ colors.violet.normal.hex | to_gnome_color }}',
  '{{ colors.cyan.normal.hex | to_gnome_color }}',
  '{{ colors.white.normal.hex | to_gnome_color }}',
  '{{ colors.black.bright.hex | to_gnome_color }}',
  '{{ colors.red.bright.hex | to_gnome_color }}',
  '{{ colors.green.bright.hex | to_gnome_color }}',
  '{{ colors.yellow.bright.hex | to_gnome_color }}',
  '{{ colors.blue.bright.hex | to_gnome_color }}',
  '{{ colors.violet.bright.hex | to_gnome_color }}',
  '{{ colors.cyan.bright.hex | to_gnome_color }}',
  '{{ colors.white.bright.hex | to_gnome_color }}'
]"
dconf write "/org/gnome/terminal/legacy/profiles:/:$profile/background-color" "'{{ colors.bg.normal.hex | to_gnome_color }}'"
dconf write "/org/gnome/terminal/legacy/profiles:/:$profile/highlight-background-color" "'{{ colors.bg.bright.hex | to_gnome_color }}'"
dconf write "/org/gnome/terminal/legacy/profiles:/:$profile/foreground-color" "'{{ colors.fg.normal.hex | to_gnome_color }}'"
dconf write "/org/gnome/terminal/legacy/profiles:/:$profile/font" "'{{ font.linux.name }} {{ font.linux.size }}'"
