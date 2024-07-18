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

#### SUBMON.SH

Subdomain monitoring with periodic updates via notifypd.
1. Add your API keys and webhooks in the right places. 
1. Run the script -> `./submon.sh target.com HRS`

#### ASM.SH

Asset discovery, monitoring and vulnerability scanning. Run it and forget it.

1. Add your API keys and webhooks in the right places. 
1. Run the script -> `./asm.sh target.com`

#### SKID.SH

1. Add your API keys in the right places. 
1. Run the script -> `./skid.sh target.com || ./skid.sh -f targets.txt`
1. Subdomain enumeration -> url crawling -> param mining -> js analysis -> lfi/xss/sqli automation
1. Profit

>This script is meant to be the slowest by design as it fuzzes a lot and looks for low hanging fruits only. Expect results to appear slow.

### Footnote

If this script helped you, or you have suggestions, feel free to hit me up :) [@cvewhen](https://x.com/cvewhen) on Twitter, [@xnu53x](discord.gg) on Discord.
