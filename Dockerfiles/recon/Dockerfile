FROM golang:latest

RUN apt update -y && apt install -y nmap vim python3 python3-pip unzip curl screen

WORKDIR /recon

COPY recon.sh /recon

RUN chmod +x /recon/recon.sh

RUN go install -v github.com/projectdiscovery/pdtm/cmd/pdtm@latest && go install -v github.com/OJ/gobuster/v3@latest && go install github.com/lc/gau/v2/cmd/gau@latest && go install github.com/ffuf/ffuf/v2@latest && go install -v github.com/tomnomnom/anew@latest

RUN pdtm -i subfinder,dnsx,httpx,nuclei,katana,chaos-client

RUN wget -P ${HOME}/.local/bin https://github.com/holly-hacker/git-dumper/releases/download/v0.1.0/git-dumper-linux && chmod +x ${HOME}/.local/bin/git-dumper-linux

RUN git clone https://github.com/debxrshi/ParamSpider ~/.local/bin/paramspider && cd ~/.local/bin/paramspider  && pip install . --break-system-packages

RUN git clone https://github.com/m4ll0k/SecretFinder.git ~/.local/bin/jssecretfinder && cd ~/.local/bin/jssecretfinder && pip install -r requirements.txt --break-system-packages && cp SecretFinder.py ../secretfinder && chmod +x ~/.local/bin/secretfinder

RUN wget -c https://github.com/danielmiessler/SecLists/archive/master.zip -O SecList.zip && unzip SecList.zip && rm -f SecList.zip && mv SecLists-master /seclists

RUN curl -sL https://raw.githubusercontent.com/epi052/feroxbuster/main/install-nix.sh | bash -s /usr/local/bin

RUN pip install waymore dirsearch arjun uro --break-system-packages

ENV PATH="/root/.local/bin:/root/.pdtm/go/bin:/root/go/bin:/usr/local/bin:${PATH}"

CMD [ "./recon.sh" ]