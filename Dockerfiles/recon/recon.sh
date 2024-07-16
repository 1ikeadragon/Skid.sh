#!/bin/bash

# RECON ONLY

echo -e '
         __   _     __       __  
   _____/ /__(_)___/ / _____/ /_ 
  / ___/ //_/ / __  / / ___/ __ \
 (__  ) ,< / / /_/ / (__  ) / / /
/____/_/|_/_/\__,_(_)____/_/ /_/ 

                      - @1ike4dr4g6on
        
-----------RECON ONLY MODE-----------                         

'

if [ -z "$1" ]; then
	echo -e "\e[33m[-]\e[0m usage: recon.sh target.com"
	exit 1
fi

target=$1
echo -e "\e[32m[+]\e[0m Processing target: $target"
echo -e "\e[32m[+]\e[0m Executing tools\n"
echo -e "\e[32m[+]\e[0m Looking for configs "
if [ -f skidconfig ]; then
	echo -e "\e[32m[+]\e[0m Copying config \n"
	# TODO: CONFIG PARSING
	chaos_key=AAAA
else
	echo -e "\e[33m[-]\e[0m Config not found! Continuing without config\n"
fi
echo -e "\e[32m[+]\e[0m Probing target with httpx"
host_probe=$(httpx -u "$target" -fr -sc -title -td -server -retries 3 -fc 404 -lc -t 500)
echo "$host_probe"
if [ -z "$host_probe" ]; then
	echo -e "\n Host seems down. Did you type the right address?"
	return 1
fi
mkdir -p "$target"
cd "$target"
echo -e "\n\e[32m[+]\e[0m Hunting subdomains with chaos \n\n"
chaos-client -d "$target" -key $chaos_key -o subs_chaos
echo -e "\n\e[32m[+]\e[0m Hunting subdomains with subfinder \n\n"
subfinder -d "$target" -all -recursive -o subs_subf -active
echo "$target" >> subs.txt
cat subs_* | anew subs.txt
if [ $(wc -l <subs) -lt 2 ]; then
	echo -e "\n No subdomains found"
else
	echo -e "\n\e[32m[+]\e[0m Probing subdomains with httpx\n\n"
	httpx -l subs -fr -random-agent -sc -title -td -server -retries 3 -fc 404 -lc -t 500
	httpx -l subs -fr -random-agent -retries 5 -fc 404 -t 500 -silent -o active_subs.txt
fi
   #dnsx shuffledns and more to be added
cd ..
