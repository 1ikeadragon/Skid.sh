#!/bin/bash

echo -e '
         __   _     __       __  
   _____/ /__(_)___/ / _____/ /_ 
  / ___/ //_/ / __  / / ___/ __ \
 (__  ) ,< / / /_/ / (__  ) / / /
/____/_/|_/_/\__,_(_)____/_/ /_/ 

                      - @1ikeadragon
        
-----------ASM MODE-----------                         

'

# subdomain enum -> get origin ip -> filter cloudflare -> monitor for changes -> run nuclei
# monitored changes: js changes, tech detect changes


if [ -z "$1" ] || [ -z "$2" ]; then
    echo -e "\033[33m[-]\033[0m usage: asm.sh target.com HRS"
    exit 1
fi


read active_subs.txt    

function vuln_scan()
function origin_ip_find()
function filter_ip()