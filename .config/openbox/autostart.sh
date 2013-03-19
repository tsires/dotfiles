# This shell script is run before Openbox launches.
# Environment variables set here are passed to the Openbox session.

# Set the desktop layput
# http://openbox.org/wiki/Help:FAQ#How_do_I_put_my_desktops_into_a_grid_layout_instead_of_a_single_row.3F
setlayout 0 4 2 0

# Set a background color
xsetroot -rv -solid "#101010"

# D-bus
if which dbus-launch >/dev/null 2>&1 && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval `dbus-launch --sh-syntax --exit-with-session`
fi

# Make GTK apps look and behave how they were set up in the gnome config tools
if test -x /usr/libexec/gnome-settings-daemon >/dev/null; then
  /usr/libexec/gnome-settings-daemon &
elif which gnome-settings-daemon >/dev/null 2>&1; then
  gnome-settings-daemon &
# Make GTK apps look and behave how they were set up in the XFCE config tools
elif which xfce-mcs-manager >/dev/null 2>&1; then
  xfce-mcs-manager n &
fi

# Preload stuff for KDE apps
if which start_kdeinit >/dev/null 2>&1; then
  LD_BIND_NOW=true start_kdeinit --new-startup +kcminit_startup &
fi

# Run XDG autostart things.  By default don't run anything desktop-specific
# See xdg-autostart --help more info
DESKTOP_ENV="OPENBOX"
if which /usr/lib/openbox/xdg-autostart >/dev/null 2>&1; then
  /usr/lib/openbox/xdg-autostart $DESKTOP_ENV
fi

# NOTE: Flickering is due to GTK theme
# Possible to use a dark theme just for these?

## Lxterminal - no flicker, but no command line options
#lxterminal --role="Embedded-1" --geometry "160x64+20+0" &
#lxterminal --role="Embedded-2" --geometry "160x64+20+0" &
#lxterminal --role="Embedded-3" --geometry "160x64+20+0" &
#lxterminal --role="Embedded-4" --geometry "160x64+20+0" &

## Gnome Terminal - Profiles to allow usable window-based terms as well, flickers
## Uses GTK 3.0 Theme
#gnome-terminal --profile="Embedded" --role="Embedded-1" --geometry "128x64+20+0" --hide-menubar &
#gnome-terminal --profile="Embedded" --role="Embedded-2" --geometry "128x64+20+0" --hide-menubar &
#gnome-terminal --profile="Embedded" --role="Embedded-3" --geometry "128x64+20+0" --hide-menubar &
#gnome-terminal --profile="Embedded" --role="Embedded-4" --geometry "128x64+20+0" --hide-menubar &

## TODO: come up with a better way to limit width (so that conky isn't hidden at lower res)
## TODO: A tiling WM?
## XFCE Terminal - Lightweight, Gnome-like, flickers
## Uses GTK 2.0 Theme
#terminal --role="Embedded-1" --geometry "100x96+20+20" --hide-menubar --hide-borders --hide-toolbars &
#terminal --role="Embedded-2" --geometry "100x96+20+20" --hide-menubar --hide-borders --hide-toolbars &
#terminal --role="Embedded-3" --geometry "100x96+20+20" --hide-menubar --hide-borders --hide-toolbars &
#terminal --role="Embedded-4" --geometry "100x96+20+20" --hide-menubar --hide-borders --hide-toolbars &

## XFCE Terminal - Lightweight, Gnome-like, flickers
#terminal --role="Embedded-1" --geometry "128x64+20+20" --hide-menubar --hide-borders --hide-toolbars &
#terminal --role="Embedded-2" --geometry "128x64+20+20" --hide-menubar --hide-borders --hide-toolbars &
#terminal --role="Embedded-3" --geometry "128x64+20+20" --hide-menubar --hide-borders --hide-toolbars &
#terminal --role="Embedded-4" --geometry "128x64+20+20" --hide-menubar --hide-borders --hide-toolbars &
#terminal --role="Embedded-5" --geometry "128x64+20+20" --hide-menubar --hide-borders --hide-toolbars &
#terminal --role="Embedded-6" --geometry "128x64+20+20" --hide-menubar --hide-borders --hide-toolbars &
#terminal --role="Embedded-7" --geometry "128x64+20+20" --hide-menubar --hide-borders --hide-toolbars &
#terminal --role="Embedded-8" --geometry "128x64+20+20" --hide-menubar --hide-borders --hide-toolbars &

# XFCE Terminal, single process, the ideal way to go
xfce4-terminal         --role="Embedded-1" --geometry "128x64+20+20" \
	--window --role="Embedded-2" --geometry "128x64+20+20" \
	--window --role="Embedded-3" --geometry "128x64+20+20" \
	--window --role="Embedded-4" --geometry "128x64+20+20" \
	--window --role="Embedded-5" --geometry "128x64+20+20" \
	--window --role="Embedded-6" --geometry "128x64+20+20" \
	--window --role="Embedded-7" --geometry "128x64+20+20" \
	--window --role="Embedded-8" --geometry "128x64+20+20" &

## XFCE Terminal, For smaller (1024x768) screens
#terminal --role="Embedded-1" --geometry "80x64+20+20" \
#	--window --role="Embedded-2" --geometry "80x64+20+20" \
#	--window --role="Embedded-3" --geometry "80x64+20+20" \
#	--window --role="Embedded-4" --geometry "80x64+20+20" \
#	--window --role="Embedded-5" --geometry "80x64+20+20" \
#	--window --role="Embedded-6" --geometry "80x64+20+20" \
#	--window --role="Embedded-7" --geometry "80x64+20+20" \
#	--window --role="Embedded-8" --geometry "80x64+20+20" &

# XFCE Terminal - Lightweight, Gnome-like, flickers
#terminal --role="Embedded-1" --geometry "160x96+20+20" --hide-menubar --hide-borders --hide-toolbars &
#terminal --role="Embedded-2" --geometry "160x96+20+20" --hide-menubar --hide-borders --hide-toolbars &
#terminal --role="Embedded-3" --geometry "160x96+20+20" --hide-menubar --hide-borders --hide-toolbars &
#terminal --role="Embedded-4" --geometry "160x96+20+20" --hide-menubar --hide-borders --hide-toolbars &

# Fancy desktop eye candy
conky -d -a top_right -c ~/.conkyrc
# TODO: make a simple command line util that combines the functionality of date
#       and figlet required for an ascii art clock
conky -d -a bottom_right -c ~/.conkyrc.clock
