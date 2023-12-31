# sesopenko/sd-scripts-install

Scripts for installation of [kohya-ss/sd-scripts](https://github.com/kohya-ss/sd-scripts) on linux. I'm trying to get it working with Cuda 1.21
so that it's more stable in the future.

## Pre-reqs

Tested with the following:

* **debian 12** (I like debian for it's stability)
* [pyenv](https://bgasparotto.com/install-pyenv-ubuntu-debian)
* `pyenv install 3.10.13`
* `pyenv virtualenv 3.10.13 sd-scripts`
* `pyenv activate sd-scripts`: you need to do this every time you run a new shell (ie: close terminal).
* [nvidia drivers](https://wallabag.seanesopenko.ca/share/6591d0ef55af53.25633884)
* [cuda toolkit 12.1](https://wallabag.seanesopenko.ca/share/6591d10e0d51f3.02615170)
  * you'll have to add some stuff to your bashrc so that cuda works, too. lots of guides out there.
* [cudnn libs installed](https://wallabag.seanesopenko.ca/share/6591b78221a8b4.37024356) for cuda 12.1
  * Put the includes and libs in your cuda folder


## create  & activatepyenv

Use a virtualenv so that the pip packages installed don't pollute other projects. Keep your host environment clean!

```bash
# see above for dev libraries required before you can do this
pyenv install 3.10.13
pyenv virtualenv 3.10.13 sd-scripts
pyenv activate sd-scripts
```

## Install dependencies

This takes 5-10 minutes on my 1GB/s internet connection. The script will ensure you've activated your
pyenv and that torch can use cuda. If either fail, it won't continue.

```bash
./install-pip-packages.sh
```


## clone & install sd-scripts~~~~

Before doing the following, `cd` to where you store all your git repos.

Watch the console for any errors. If any occur, sort those out before continuing

This took 10-15 minutes for me because it was pulling multiple versions of torchvision to figure out
which was compatible with other requirements. It took foreeeeeever.

```bash
git clone https://github.com/kohya-ss/sd-scripts.git
cd sd-scripts

pyenv activate sd-scripts

pip install --upgrade -r requirements.txt

accelerate config

```

## Random improvements

### pycharm file system performance

If you get a warning from Pycharm that external file changes sync may be slow, fix it with [inotify settings](https://stackoverflow.com/questions/67927480/how-to-fix-these-warnings-external-file-changes-sync-may-be-slow-and-the-curr).

### Dualbooting Debian 12 and Windows 11

Windows 11 needs HD encryption and likes having secureboot enabled. Debian 12 supports this.  Do this before installing
your nvidia drivers.

First install DKMS~~~~

```bash
apt update && apt upgrade
# restart if there were any kernel updates
apt install dkms
```

Follow the instructions from this site:

[debian secure boot mok keys](https://wiki.debian.org/SecureBoot#Finding_Debian.27s_SB_keys)

[link from my wallabag in case the above disappears](https://wallabag.seanesopenko.ca/share/6591d227274766.73075722)

Do the following:

* Generate a new mok key (create a custom mok), key needs a password
* Enroll your key
* reboot your computer
* accept the key with the password you've configured, enter key password from mok key generation
* Add your key to dkms
* Set linux kernel info variables in your `.bashrc`
* Using your key to sign your kernel

Then install your [nvidia drivers](https://wallabag.seanesopenko.ca/share/6591d0ef55af53.25633884).

### keeping git repos tidy

Over time, a development environment will have lots of git repos.  Putting all of the repos flat in a single directory
eventually leads to conflics in project names and difficulty understanding what projects are for what.
Plus, when pulling repos from github, gitlab, etc, it can get even more confusing.

This is the structure I use:

* `~/src`: main directory where all repos are located
  *  `<service_name>`: ie `github.com`. This keeps github & gitlab repos tidy
      * `<user>`: ie: `sesopenko`, `kohya-ss`, `comfyanonymous`: this avoids conflicts in repo names
        * `<repo_name>`: ie: `sd-scripts`, `ComfyUI`, `sd-scripts-install`

ie:

```
~/src
  github.com/
    sesopenko/
      sd-scripts-install
    kohya-ss/
      sd-scripts
  gitlab.com/
    Inkscape/
      inkscape
```

This also helps keep day-job corporate projects separated from personal projects when night hacking, such as
keeping the corporate bitbucket separate from github.com projects.