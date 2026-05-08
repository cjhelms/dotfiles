#!/usr/bin/env bash
set -euo pipefail

PROFILE_ID="$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")"
PROFILE="org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${PROFILE_ID}/"

# habamax
gsettings set "${PROFILE}" use-theme-colors false
gsettings set "${PROFILE}" background-color '#1c1c1c'
gsettings set "${PROFILE}" foreground-color '#c7c7c7'
gsettings set "${PROFILE}" palette "['#1c1c1c', '#af5f5f', '#5faf5f', '#af875f', '#5f87af', '#af87af', '#5f8787', '#9e9e9e', '#767676', '#d75f87', '#87d787', '#d7af87', '#5fafd7', '#d787d7', '#87afaf', '#c7c7c7']"
