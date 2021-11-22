#!/bin/bash

redColour="\e[0;31m"
blueColour="\e[0;34m"
yellowColour="\e[0;33m"
cyanColour="\e[0;36m"
endColour="\e[0\e0"


function ctrl_c(){
        echo -e "${redColour} \n[!]Exiting..\n${endColour}"
        exit 1
}

trap ctrl_c INT

os=""
counter=1


if [[ $1 == "" ]]; then
        echo -e "${redColour}[!]Use: $0 x.x.x ${endColour}"
else
        for i in $(seq 1 300); do

                 timeout 1 bash -c "ping -c 1 $1.$i" >/dev/null  &&
                 bash -c "ping -c 1 $1.$i" > rangeIp.tmp &&
                 ttl="$(cat rangeIp.tmp | grep -o 'ttl=...' | sed 's/ttl\=//' | sed 's/ //')";
                 if [[ $ttl -eq 0 ]]; then
                        os="";
                 elif [[ $ttl -gt 0 ]] && [[ $ttl -le 64 ]];then
                        os="Linux";
                         echo -e "${blueColour}$counter.-\t[*] Active ${yellowColour}$1.$i\t${cyanColour}$os${endColour}${endColour}${endColur}";
                        ttl="0"
                        let counter+=1
                 elif  [[ $ttl -gt 64 ]] && [[ $ttl -le 128 ]]; then
                        os="Windows";
                        echo -e "${blueColour}$counter.-\t[*] Active ${yellowColour}$1.$i\t${cyanColour}$os${endColour}${endColour}${endColur}";
                        ttl="0"
                        let counter+=1
                fi;
                rm rangeIp.tmp 2>/dev/null &

        done; wait
fi

