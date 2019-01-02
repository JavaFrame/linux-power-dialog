#!/bin/bash
# Default acpi script that takes an entry for all actions

function showRofi {
    return=$(echo -e "Lock\nHibernate\nShutdown\nReboot" | rofi -dmenu)
    logger $return 
    case $return in
        "Lock") dm-tool switch-to-greeter;;
        "Hibernate") systemctl suspend-then-hibernate;;
        "Shutdown") systemctl poweroff;;
        "Reboot") systemctl reboot;;
    esac
}

function lock {
    dm-tools switch-to-greeter
}

case "$1" in
    button/power)
        case "$2" in
            PBTN|PWRF)
                logger 'handler_power_gui.sh: PowerButton pressed'
                showRofi
                ;;
            *)
                logger "handler_power_gui.sh: ACPI action undefined: $2"
                ;;
    button/lid)
        case "$3" in
            close)
                logger 'LID closed'
                dm-tool switch-to-greeter
                ;;
            open)
                logger 'LID opened'
                ;;

        esac
        ;;
esac

# vim:set ts=4 sw=4 ft=sh et:
