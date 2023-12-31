# sesopenko/sd-scripts-install

Scripts for installation of [kohya-ss/sd-scripts](https://github.com/kohya-ss/sd-scripts) on linux. I'm trying to get it working with Cuda 1.21
so that it's more stable in the future.

## Pre-reqs

Tested with the following:

* **debian 12** (I like debian for it's stability)
* pyenv
* create a pyenv with python 3.10.13
* activate pyenv
* cuda toolkit 12.1
  * you'll have to add some stuff to your bashrc so that cuda works, too. lots of guides out there.
* cudnn libs [installed](https://wallabag.seanesopenko.ca/share/6591b78221a8b4.37024356) for cuda 12.1
  * Put the includes and libs in your cuda folder

I had to install [a bunch of developer libraries for python](https://gist.github.com/drconopoima/e7cdbbbf6c7ea51fc1e26b5576c5e6ef) **before** I could use pyenv properly:

```bash
# If you tried installing python with pyenv BEFORE doing this, delete your previous pyenv python install with
# pyenv uninstall <version_you_installed>, then reinstall again.

sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev git
```

## create  & activatepyenv

Use a virtualenv so that the pip packages installed don't pollute other projects. Keep your host environment clean!

```bash
# see above for dev libraries required before you can do this
pyenv install 3.10.13
pyenv virtualenv 3.10.13 sd-scripts
pyenv activate sd-scripts
```

## Install torch for cuda

```bash
pip install torch==2.1.0+cu121 torchvision==0.16+cu121 --index-url https://download.pytorch.org/whl/cu121
```

