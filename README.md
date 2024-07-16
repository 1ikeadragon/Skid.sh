# Bug Bounty Automation Setup

```
   _____ __   _     __       __
  / ___// /__(_)___/ / _____/ /_
  \__ \/ //_/ / __  / / ___/ __ \
 ___/ / ,< / / /_/ / (__  ) / / /
/____/_/|_/_/\__,_(_)____/_/ /_/

                    -- @debxrshi

```

### Flow

subdomain enumeration -> url crawling -> param mining -> js analysis -> lfi/xss/sqli automation

### Tool setup

You can either build with docker:

```sh
docker build -t skid:skid .
```

Or,

run `install.sh` to install tools locally. Script is configured for an Ubuntu VPS with Golang installed.

### Usage

#### RECON ONLY Mode
If you just want to perform recon on your target(s) it's advisable to run the `recon.sh` script. It will perform all the recon you need for you and can also be run in subdomain monitoring mode with your discord webhook.

1. Create a file `skidconfig`
1. Add your API keys in the file including webhooks. Check the demo file for correct format.
1. Run the script `./recon.sh target.com || ./recon.sh -f targets.txt`

#### FULL SCAN Mode
1. Create a file `skidconfig`
1. Add your API keys in the file. 
1. Run the script -> `./skid.sh target.com || ./skid.sh -f targets.txt`
1. ???
1. Profit

### Footnote

If this script helped you, or you have suggestions, feel free to hit me up :) [@cvewhen](https://x.com/cvewhen) on Twitter, [@xnu53x](discord.gg) on Discord.
