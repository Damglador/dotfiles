#!/bin/sh
# Force system file picker
#export QT_QPA_PLATFORMTHEME=xdgdesktopportal # Do not use with Plasma session
export GTK_USE_PORTAL=1 GDK_DEBUG=portals

export PYTHONPATH="$PYTHONPATH:$HOME/.local/lib/python3.12/site-packages:./.venv/lib/python3.13/site-packages/"

for file in "${XDG_CONFIG_HOME:-$HOME/.config}/profile.d/"*.sh; do
  . "$file"
done
