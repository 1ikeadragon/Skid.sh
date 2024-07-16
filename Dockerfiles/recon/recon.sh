#!/bin/bash

# RECON ONLY

echo -e '
         __   _     __       __  
   _____/ /__(_)___/ / _____/ /_ 
  / ___/ //_/ / __  / / ___/ __ \
 (__  ) ,< / / /_/ / (__  ) / / /
/____/_/|_/_/\__,_(_)____/_/ /_/ 

                      - @debxrshi
        
-----------RECON ONLY MODE-----------                         

'

if [ -z "$1" ]; then
	echo -e "\e[33m[-]\e[0m usage: skid.sh target.com | skid.sh -f targets.txt"
	exit 1
fi

process_target() {
	local target=$1
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
}

#TODO: File parsing not working
if [ "$1" == "-f" ]; then
	if [ -z "$2" ]; then
		echo -e "\e[33m[-]\e[0m Please provide a file name with -f option."
		exit 1
	fi

	file="$2"
	if [ ! -f "$file" ]; then
		echo -e "\e[33m[-]\e[0m File $file not found!"
		exit 1
	fi

	while IFS= read -r target; do
		if ! process_target "$target"; then
			continue
		fi
		if [ -d "$target" ]; then
			cd ..
		fi
	done <"$file"
else
	process_target "$1"
fi
