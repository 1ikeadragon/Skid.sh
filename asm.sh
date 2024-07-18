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



if [ -z "$1" ] || [ -z "$2" ]; then
    echo -e "\e[33m[-]\e[0m usage: submon.sh target.com HRS"
    exit 1
fi

target=$1
hrs=$2

./submon.sh $target $hrs

read active_subs.txt    
