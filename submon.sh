#!/bin/bash

echo -e '
         __   _     __       __  
   _____/ /__(_)___/ / _____/ /_ 
  / ___/ //_/ / __  / / ___/ __ \
 (__  ) ,< / / /_/ / (__  ) / / /
/____/_/|_/_/\__,_(_)____/_/ /_/ 

                      - @1ikeadragon
        
-----------SUB MONITORING MODE-----------                         

'

if [ -z "$1" ] || [ -z "$2" ]; then
    echo -e "\e[33m[-]\e[0m usage: submon.sh target.com HRS"
    exit 1
fi

target=$1
hrs=$2

function run_monitoring() {
    echo -e "\e[32m[+]\e[0m Processing target: $target\n"

    function parse_provider_config() {
        provider_config_path="$HOME/.config/subfinder/provider-config.yaml"
        if [ -f "$provider_config_path" ]; then
            echo -e "\e[32m[+]\e[0m Provider config file found! Parsing config...\n"
        else
            echo -e "\e[33m[-]\e[0m Provider config file not found! Continuing without API keys"
        fi
    }

    parse_provider_config

    echo -e "\e[32m[+]\e[0m Probing target with httpx\n"
    host_probe=$(httpx -u "$target" -fr -silent -sc -title -td -server -retries 3 -fc 404 -lc -t 500)
    if [ -z "$host_probe" ]; then
        echo -e "\n Host seems down. Did you type the right address?"
        exit 1
    fi

    echo -e "\n\e[32m[+]\e[0m Hunting subdomains with subfinder \n\n"
    subs=$(subfinder -d "$target" -all -recursive -silent)

    echo -e "\n\e[32m[+]\e[0m Probing subdomains with httpx\n\n"
    active_subs=$(echo "$subs" | httpx -silent -random-agent -retries 3 -fc 404,301,302 -nc)

    if [ -z "$active_subs" ]; then
        echo -e "\n No active subdomains found"
    else
        sorted_active_subs=$(echo "$active_subs" | sed 's|http[s]\?://||' | sort)

        if [ -f "active_subs.txt" ]; then
            sorted_old_active_subs=$(sort active_subs.txt)

            changes=$(diff <(echo "$sorted_old_active_subs") <(echo "$sorted_active_subs"))

            if [ -n "$changes" ]; then
                added_lines=$(echo "$changes" | grep "^>" | sed 's/^> //')
                removed_lines=$(echo "$changes" | grep "^<" | sed 's/^< //')

                formatted_changes=""
                if [ -n "$added_lines" ]; then
                    formatted_changes+="Added subdomains:\n\n$added_lines\n"
                fi
                if [ -n "$removed_lines" ]; then
                    formatted_changes+="Removed subdomains:\n\n$removed_lines\n"
                fi

                echo -e "$formatted_changes" | notify -silent
            else
                echo -e "\n\e[32m[+]\e[0m No changes detected in active subdomains.\n"
            fi
        else
            echo -e "\n\e[32m[+]\e[0m Creating active_subs.txt for the first time.\n"
            echo "$sorted_active_subs" > active_subs.txt
            echo "$sorted_active_subs" | notify -silent
        fi

        echo -e "\n\e[32m[+]\e[0m Active subdomains:\n"
        echo "$sorted_active_subs"
    fi
}

while true; do
    run_monitoring
    echo -e "\n\e[32m[+]\e[0m Sleeping for: $hrs hours\n"
    sleep $((hrs * 3600))
done
