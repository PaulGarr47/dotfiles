# start Hyprland through UWSM (choice)
if uwsm check may-start && uwsm select; then
	exec uwsm start default
fi
# start Hyprland through UWSM (no choice)
# if uwsm check may-start; then
#    exec uwsm start hyprland-uwsm.desktop
 fi
