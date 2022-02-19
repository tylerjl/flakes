#!/usr/bin/env bash

app="Rofi TOTP Menu"
delay=20000
icon=dialog-password
title=Yubikey

[[ "$@" == "Retry" ]] && shift
[[ "$@" == "Cancel" ]] && exit 1

if [[ $# -eq 0 ]]; then
    accounts=($(ykman oath accounts list))
    if [[ $? -ne 0 ]]
    then
        echo -e "\0message\x1fCouldn't retrieve accounts, is the Yubikey connected?"
        echo -e "\0no-custom\x1ftrue"
        echo -e "Retry\0icon\x1fview-refresh"
        echo -e "Cancel\0icon\x1fwindow-close"
    else
        echo -e "\0message\x1fSelect account to generate from Yubikey"
        echo -e "\0no-custom\x1ftrue"
        for account in ${accounts[@]}
        do
            echo -e "${account}\0icon\x1fkeyring-manager"
        done
    fi
else
    notify-send --icon=$icon --app-name="${app}" --expire-time=$delay \
        "${title}" "Waiting for Yubikey touch..." &>/dev/null
    ykman oath accounts code --single $1 2>/dev/null \
        | tr -d "\n" \
        | xclip -selection clipboard &> /dev/null
    dunstctl close
    notify-send --icon=$icon --app-name="${app}" \
        "${title}" "One-time password for <b>${1}</b> has been copied to the clipboard." &>/dev/null
    echo
fi
