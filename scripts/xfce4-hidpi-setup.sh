#!/bin/bash
# XFCE 4K 27" display scaling configuration
# Run this script after XFCE starts or add to autostart

# Set DPI for XFCE
xfconf-query -c xsettings -p /Xft/DPI -s 192

# Enable window scaling
xfconf-query -c xfwm4 -p /general/theme -s "Default-hdpi"

# Set icon size (optional, adjust as needed)
xfconf-query -c xsettings -p /Gtk/IconSizes -s "gtk-menu=32,32:gtk-button=32,32:gtk-small-toolbar=32,32:gtk-large-toolbar=48,48:gtk-dialog=64,64"

# Panel configuration (if using default panel)
# Adjust panel size for HiDPI - uncomment if needed
# xfconf-query -c xfce4-panel -p /panels/panel-1/size -s 48

# Terminal font size (adjust as needed)
xfconf-query -c xfce4-terminal -p /font-name -s "IosevkaTerm Nerd Font Propo 12"

# Set cursor theme and size
xfconf-query -c xsettings -p /Gtk/CursorThemeName -s "Adwaita"
xfconf-query -c xsettings -p /Gtk/CursorThemeSize -s 32

# Notification daemon font size
xfconf-query -c xfce4-notifyd -p /theme -s "Default"

echo "XFCE HiDPI configuration applied successfully"
echo "Please log out and log back in for all changes to take effect"
