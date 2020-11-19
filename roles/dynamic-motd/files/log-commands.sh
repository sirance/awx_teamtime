#!/bin/bash
#
# Log all commands to syslog. Source this from an interactive shell, e.g. in
# root's ~/.bashrc.
#

LH_LASTLINE=('' '')

if test -t 1; then
        if test -z "$LH_TTY"; then
                LH_TTY=$(/usr/bin/tty 2>/dev/null)
                LH_TTY=${LH_TTY#/dev/}
                test -z "$LH_TTY" && LH_IP="unknown"
                test -z "$LH_TTY" && LH_TTY="unknown"
        fi
        if test -z "$LH_IP"; then
                LH_IP=($(/usr/bin/last -i -1 "$LH_TTY" 2>/dev/null))
                LH_IP=${LH_IP[2]}
                test -z "$LH_IP" && LH_IP="unknown"
        fi
fi

function log_history () {
        local -a lh_last

        trap "log_history" 0

        test -z "${LH_LASTLINE[0]}" && LH_LASTLINE=($(history 1))
        test -z "${LH_LASTLINE[0]}" && LH_LASTLINE=(`wc -l ~/.bash_history 2>/dev/null || echo 0`)

        lh_last=($(history 1))
        ((${lh_last[0]}>${LH_LASTLINE[0]})) || return
        LH_LASTLINE[0]=${lh_last[0]}
        unset lh_last[0]

        echo "[${LH_IP}@${LH_TTY}:$EUID] ${lh_last[*]}" | /usr/bin/logger -p user.info -t 'bash'
}

PROMPT_COMMAND="log_history;$PROMPT_COMMAND"