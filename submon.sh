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

if [ -z "$1" ]; then
    echo -e "\e[33m[-]\e[0m usage: submon.sh target.com"
    exit 1
fi

target=$1
echo -e "\e[32m[+]\e[0m Processing target: $target\n"

function parse_provider_config() {
    provider_config_path="$HOME/.config/subfinder/provider-config.yaml"
    if [ -f "$provider_config_path" ]; then
        echo -e "\e[32m[+]\e[0m Provider config file found! Parsing config...\n"
        chaos_key=$(awk '/chaos:/ {getline; print $2}' "$provider_config_path")
        if [ -z "$chaos_key" ]; then
            echo -e "\e[33m[-]\e[0m CHAOS API key not found in provider-config.yaml"
            chaos_key=""  
        fi
    else
        echo -e "\e[33m[-]\e[0m Provider config file not found! Continuing without API keys"
    fi
}

parse_provider_config

echo -e "\e[32m[+]\e[0m Probing target with httpx\n"
host_probe=$(httpx -u "$target" -fr -sc -title -td -server -retries 3 -fc 404 -lc -t 500)
echo "$host_probe"
if [ -z "$host_probe" ]; then
    echo -e "\n Host seems down. Did you type the right address?"
    exit 1
fi

mkdir -p "$target"
cd "$target"

echo -e "\n\e[32m[+]\e[0m Hunting subdomains with chaos \n\n"
chaos-client -d "$target" -key "$chaos_key" -o subs_chaos 1>/dev/null

echo -e "\n\e[32m[+]\e[0m Hunting subdomains with subfinder \n\n"
subfinder -d "$target" -all -recursive -o subs_subf -active 1>/dev/null
echo "$target" >> subs.txt
cat subs_* | anew subs.txt >/dev/null

rm subs_*

if [ $(wc -l <subs.txt) -lt 2 ]; then
    echo -e "\n No subdomains found"
else
    echo -e "\n\e[32m[+]\e[0m Probing subdomains with httpx\n\n"
    httpx -l subs.txt -fr -random-agent -sc -title -td -server -retries 3 -fc 404 -lc -t 500 1>/dev/null
    httpx -l subs.txt -fr -random-agent -retries 5 -fc 404 -t 500 -silent -o active_subs.txt 1>/dev/null

    if [ -f "../active_subs.txt" ]; then
        changes=$(diff active_subs.txt ../active_subs.txt)
        if [ -n "$changes" ]; then
            echo "$changes" | notify
        fi
    else
        cp active_subs.txt ..
    fi

    echo -e "\n\e[32m[+]\e[0m Active subdomains:\n"
    cat active_subs.txt
fi

echo -e "\n\e[32m[+]\e[0m Active subdomains:\n"

sleep 3600