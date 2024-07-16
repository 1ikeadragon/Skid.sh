FROM golang:latest

RUN apt update -y && apt install -y nmap git vim python3 python3-pip unzip curl screen

WORKDIR /recon

COPY recon.sh /recon

RUN chmod +x /recon/recon.sh

RUN go install -v github.com/projectdiscovery/pdtm/cmd/pdtm@latest && go install -v github.com/OJ/gobuster/v3@latest && go install github.com/lc/gau/v2/cmd/gau@latest && go install github.com/ffuf/ffuf/v2@latest && go install -v github.com/tomnomnom/anew@latest

RUN pdtm -i subfinder,dnsx,httpx,nuclei,katana,chaos-client,notify

ENV PATH="/root/.local/bin:/root/.pdtm/go/bin:/root/go/bin:/usr/local/bin:${PATH}"

CMD [ "./recon.sh" ]