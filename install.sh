sudo apt update -y && apt install -y nmap neovim python3 python3-pip unzip curl screen

go install -v github.com/projectdiscovery/pdtm/cmd/pdtm@latest && go install -v github.com/OJ/gobuster/v3@latest && go install github.com/lc/gau/v2/cmd/gau@latest && go install github.com/hahwul/dalfox/v2@latest && go install github.com/ffuf/ffuf/v2@latest

export PATH=$PATH:$HOME/go/bin

export PATH=$PATH:$HOME/.pdtm/go/bin

echo 'export PATH=$PATH:$HOME/.pdtm/go/bin:$HOME/go/bin' >>~/.bashrc

source ~/.bashrc

pdtm -i subfinder,dnsx,httpx,katana,chaos-client,nuclei

wget -P ${HOME}/.local/bin https://github.com/holly-hacker/git-dumper/releases/download/v0.1.0/git-dumper-linux && chmod +x ${HOME}/.local/bin/git-dumper-linux

git clone https://github.com/devanshbatham/paramspider ~/.local/bin/paramspider && cd ~/.local/bin/paramspider && pip install .

git clone https://github.com/m4ll0k/SecretFinder.git ~/.local/bin/gitsecretfinder && cd ~/.local/bin/gitsecretfinder && pip install -r requirements.txt && cp SecretFinder.py ../secretfinder && chmod +x ~/.local/bin/secretfinder

git clone https://github.com/r0oth3x49/ghauri ~/.local/bin/ghauri && cd ~/.local/bin/ghauri && pip install --upgrade -r requirements.txt

git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git ~/.local/bin/sqlmap-dev && cd ~/.local/bin/sqlmap-dev && chmod +x sqlmap.py && cp sqlmap.py ../sqlmap

wget -c https://github.com/danielmiessler/SecLists/archive/master.zip -O SecList.zip && unzip SecList.zip && rm -f SecList.zip && mv SecLists-master /seclists

curl -sL https://raw.githubusercontent.com/epi052/feroxbuster/main/install-nix.sh | bash -s /usr/local/bin

pip install waymore dirsearch arjun xsstrike uro

echo 'export PATH=$PATH:$HOME/.local/bin' >>~/.bashrc

echo -e "\n Make sure to source your .bashrc!\n"
