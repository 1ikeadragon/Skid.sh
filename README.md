# Automation goes brrrr

```
   _____ __   _     __       __
  / ___// /__(_)___/ / _____/ /_
  \__ \/ //_/ / __  / / ___/ __ \
 ___/ / ,< / / /_/ / (__  ) / / /
/____/_/|_/_/\__,_(_)____/_/ /_/

                    -- @1ikeadragon

```

### Tool setup

You can either build with docker:

```sh
docker build -t skid:skid .
```

Or,

run `install.sh` to install tools locally. Script is configured for an Ubuntu VPS with Golang installed.

### Usage

If you just want to perform recon on your target(s) it's advisable to run the `submon.sh` script. It will perform all the recon you need for you and contineuously monitor for new assets. For a mini asm-esque setup, run `asm.sh`.

Set up the `skid.yaml` file with your API keys, wordlist directories, webhooks, etc and run any of the scripts. Example config file:
```yaml
subfinder:
  chaos: 
    - safsfaf-311-4e113-accg2
  certspotter: 
    - 31-31h1b
  shodan: 
    - jrajllfafieifhalfaflalfh2112-31-31h1b
  binaryedge: 
    - 10010001111c-1101-ssaff-ad42-ddd5e77c4548
  censys: 
    - bx6e18d-fcc3-45x3-11c7-sff2ffllg:Abc23JJVk0afafakj

webhooks:
  discord:
    - id: "submon"
      discord_channel: "skidsh"
      discord_username: "submon"
      discord_format: "{{data}}"
      discord_webhook_url: "https://discord.com/api/webhooks/XXXXXXXX"
    - id: "crawl"
      discord_channel: "skidcrawl"
      discord_username: "crawler"
      discord_format: "{{data}}"
      discord_webhook_url: "https://discord.com/api/webhooks/XXXXXXXX"

wordlists:
  resolver:
    - "/usr/share/wordlists/dns.txt"
  subdomain:
    - "/usr/share/wordlists/sub.txt"
  directory:
    - "/usr/share/wordlists/directorybrute.txt"
```
If you use the config file, data from it ***will overwrite*** your tools config files.
#### SUBMON.SH

Subdomain monitoring with periodic updates via notifypd.
1. Add your API keys and webhooks in `skid.yaml`.
2. Run the script -> `./submon.sh target.com HRS`

#### ASM.SH [WIP]

Asset discovery, monitoring and vulnerability scanning. Run it and forget it.

1. Add your API keys and webhooks in `skid.yaml`.
2. Run the script -> `./asm.sh target.com`

#### SKID.SH [WIP]

1. Add your API keys and webhooks in `skid.yaml`.
2. Run the script -> `./skid.sh target.com || ./skid.sh -f targets.txt`
3. Subdomain enumeration -> url crawling -> param mining -> js analysis -> lfi/xss/sqli automation
4. Profit

This script is meant to be the slowest by design as it fuzzes a lot and looks for low hanging fruits only. Expect results to appear slow.
### Footnote

If this script helped you, or you have suggestions, feel free to hit me up :) [@cvewhen](https://x.com/cvewhen) on Twitter, [@xnu53x](discord.gg) on Discord.
