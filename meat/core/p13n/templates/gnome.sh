#!/bin/bash

profile=$(gsettings get org.gnome.Terminal.ProfilesList list | tr -d \'[])
dconf write "/org/gnome/terminal/legacy/profiles:/:$profile/palette" "[
  '{{ colors.black.normal | to_gnome_color }}',
  '{{ colors.red.normal | to_gnome_color }}',
  '{{ colors.green.normal | to_gnome_color }}',
  '{{ colors.yellow.normal | to_gnome_color }}',
  '{{ colors.blue.normal | to_gnome_color }}',
  '{{ colors.violet.normal | to_gnome_color }}',
  '{{ colors.cyan.normal | to_gnome_color }}',
  '{{ colors.white.normal | to_gnome_color }}',
  '{{ colors.black.bold | to_gnome_color }}',
  '{{ colors.red.bold | to_gnome_color }}',
  '{{ colors.green.bold | to_gnome_color }}',
  '{{ colors.yellow.bold | to_gnome_color }}',
  '{{ colors.blue.bold | to_gnome_color }}',
  '{{ colors.violet.bold | to_gnome_color }}',
  '{{ colors.cyan.bold | to_gnome_color }}',
  '{{ colors.white.bold | to_gnome_color }}'
]"
dconf write "/org/gnome/terminal/legacy/profiles:/:$profile/background-color" "'{{ colors.bg.normal | to_gnome_color }}'"
dconf write "/org/gnome/terminal/legacy/profiles:/:$profile/highlight-background-color" "'{{ colors.bg.bold | to_gnome_color }}'"
dconf write "/org/gnome/terminal/legacy/profiles:/:$profile/foreground-color" "'{{ colors.fg.normal | to_gnome_color }}'"
dconf write "/org/gnome/terminal/legacy/profiles:/:$profile/font" "'{{ font.linux.name }} {{ font.linux.size }}'"
