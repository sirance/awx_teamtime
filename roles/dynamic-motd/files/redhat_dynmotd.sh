#!/bin/bash
 
uptime=$(</proc/uptime)
uptime=${uptime%%.*}
seconds=$(( uptime%60 ))
minutes=$(( uptime/60%60 ))
hours=$(( uptime/60/60%24 ))
days=$(( uptime/60/60/24 ))

PROCCOUNT=`ps -Afl | wc -l`
PROCCOUNT=`expr $PROCCOUNT - 5`
 
echo -e "\033[1;32m _ _
`figlet \`hostname -s\`` 
\033[0;35m+++++++++++++++++: \033[0;37mSystem Data\033[0;35m :+++++++++++++++++++
+  \033[0;37mHostname \033[0;35m= \033[1;32m`hostname`
\033[0;35m+   \033[0;37mAddress \033[0;35m= \033[1;32m`ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/'`
\033[0;35m+\033[0;37m   Version \033[0;35m= \033[1;32m`cat /etc/redhat-release`
\033[0;35m+    \033[0;37mKernel \033[0;35m= \033[1;32m`uname -r`
\033[0;35m+    \033[0;37mUptime \033[0;35m= \033[1;32m$days days, $hours hours, $minutes minutes, $seconds seconds
\033[0;35m+ \033[0;37mCPU Usage \033[0;35m= \033[1;32m`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4 + $6 + $10 }'`%
\033[0;35m+    \033[0;37mMemory \033[0;35m= \033[1;32m`free -m | grep Mem | awk '{ print $3 }'`Mb of `free -m | grep Mem | awk '{ print $2 }'`Mb used
\033[0;35m+  \033[0;37mUsername \033[0;35m= \033[1;32m`whoami`
\033[0;35m+\033[0;37m      Time \033[0;35m= \033[1;32m`date +'%T %a %d/%m/%y'`
\033[0;35m+++++++++++++++++++++++++++++++++++++++++++++++++++ \033[0;0m"