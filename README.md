# Red Eclipse CLI
[![](https://cdn.discordapp.com/attachments/645134776466014220/953440742070706286/cli.png)](https://cdn.discordapp.com/attachments/645134776466014220/953440742070706286/cli.png)

Red Eclipse CLI is a universally compatible command line interface for many common Linux versions to carry out and manage Red Eclipse installations comfortably and quickly.
This CLI will help you to install and mantain the Red Eclipse stable and development version directly from the official [Red Eclipse](https://github.com/redeclipse/ "Red Eclipse") GitHub repository.

[![](https://media.discordapp.net/attachments/645134776466014220/953442300724379718/cli2.png)](https://media.discordapp.net/attachments/645134776466014220/953442300724379718/cli2.png)

**Features of the cli:**
- install / reinstall / uninstall
- install all dependencies
- compile / recompile
- update
- start
- install small server builds (great for installing new servers quick)
- making this CLI systemwide accessible
- quick CLI and full CLI
- CLI auto update (this CLI updates it self if a new release is done)
- verbose mode #coming soon
- debug mode #coming soon

[![](https://cdn.discordapp.com/attachments/645134776466014220/953624778491723807/cli3.png)](https://cdn.discordapp.com/attachments/645134776466014220/953624778491723807/cli3.png)

**Supported Linux base distros currently detected:**
- Arch Linux based
- Debian based
- Ubuntu based
- SuSE based
- Red Hat based
- CentOS based
- Gentoo based
- Fedora based

**Paths & defaults:**
The CLI will install Red Eclipse under `/home/$USER/.redeclipse/game` by default. This can be modified inside the `redeclipse_cli.sh` file under the section *config* at the beginning.

**Installing the CLI:**
You don't need to install it, after a done Red Eclipse install you can decide if the CLI should systemwide accessible, then you can use it everywhere with just `redeclipse_cli`.

**How to use the CLI:**
1. download and extract
2. run it `./redeclipse_cli.sh` or `./redeclipse_cli.sh -h` for the quick ui

*That's all!*

*If you face an error you need to make it executable with `chmod +x redeclipse_cli.sh`

**!Attention!**
This CLI is in a very early state and may have some bugs! So becareful using it!

Reporting issues and improvement ideas are allways welcome.
