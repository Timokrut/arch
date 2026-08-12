#!/bin/sh

export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=bspwm
export XDG_SESSION_DESKTOP=bspwm

export XCURSOR_THEME="Dracula-cursors"
export XCURSOR_SIZE=24

dbus-update-activation-environment --systemd \
    DISPLAY \
    XAUTHORITY \
    XDG_SESSION_TYPE \
    XDG_CURRENT_DESKTOP \
    XDG_SESSION_DESKTOP

exec sxhkd &
exec bspwm
