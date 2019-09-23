# kitchen-vagrant
Kitchen-vagrant test that checks the vagrant virtualbox box have nginx

Based on https://github.com/Galser/packer-nginx64

# Purpose

This repository contains Kitchen tests for [Vagrant BirtualBox with Nginx](https://github.com/Galser/packer-nginx64) that checks the fact that Nginx is indeed installed.

For the notes on how to build basic box with Nginx please refer to [this README in the prototype repo](https://github.com/Galser/packer-nginx64/blob/master/README.md). 

# Instructions

- To download the copy of the code (*clone* in Git terminology) - go to the location of your choice (normally some place in home folder) and run in terminal; in case you are using alternative Git Client - please follow appropriate instruction for it and download(*clone*) [this repo](https://github.com/Galser/kitchen-vagrant.git). 
```
git clone https://github.com/Galser/kitchen-vagrant.git
```

- Previous step should create the folder that contains copy of repository. Default name is going to be the same as the name of repository e.g. `kitchen-vagrant`. Locate and open it.
```
cd kitchen-vagrant
```
- Install rbenv (.ruby-version) 
- Us HomeBrew to install rbenv
- Make appropiate env changes :
    - macOs with BASH as the default  shell
    ```
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    source ~/.bash_profile
    rbenv init
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    source ~/.bash_profile
    ```
    - macOS with ZSH as default shell (credits to :  [Rod Wilhelmy](https://coderwall.com/wilhelmbot) ) :
    ```
    $ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshenv
    $ echo 'eval "$(rbenv init -)"' >> ~/.zshenv
    $ echo 'source $HOME/.zshenv' >> ~/.zshrc
    $ exec $SHELL
    ```
    - Linux (Debian flavored):

    > Note: On Graphical environments, when you open a shell, sometimes ~/.bash_profile doesn't get loaded You may need to source ~/.bash_profile manually or use ~/.bashrc
    ```
    apt update
    apt install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev
    wget -q https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer -O- | bash
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    source ~/.bash_profile
    rbenv init
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    source ~/.bash_profile
    ```
    
    For other distributions please refer to your system's appropriate manuals 

- Install required Ruby version and choos it as default local : 
```
rbenv install 2.3.1
rbenv local 2.3.1
```
- Check that your setting are correct by executing :
```
rbenv versions
```
Output should like something like this : 
```
 system
* 2.3.1 (set by /Users/.../kitchen-vagrant/.ruby-version)
  2.6.0
```
Yours can list other versions also, due to the difference in environments, but the important part is that you should have that asterisk (*) symbol in front of the Ruby version 2.3.1 marking it as active at the current moment
- To simplify our life and to install required Rub packages we are going to use **Ruby bundler** (See : https://bundler.io/ ). Let's install it. Execute : 
```
gem install bundler
```
- Install KitchenCI and other required **Ruby Gems**, the repository comes with the [Gemfile](Gemfile) that list all that required. ( Check ) :
```
bundle install
```
Output going to span several pages, but the last part should be : 
```
Fetching test-kitchen 2.3.3
Installing test-kitchen 2.3.3
Fetching kitchen-inspec 1.2.0
Installing kitchen-inspec 1.2.0
Fetching kitchen-vagrant 1.6.0
Installing kitchen-vagrant 1.6.0
Bundle complete! 4 Gemfile dependencies, 107 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```




# Technologies

- **KitchenCI** - provides a test harness to execute infrastructure code on one or more platforms in isolation. FGor more details please check the productl site : [KitchenCI](https://kitchen.ci/)

- **Homebrew** - is atool for MacOS installs the stuff you need that Apple (or your Linux system) didn’t. Check in details and instruction how to install [here](https://brew.sh/)

- **RubyGems** is a package manager for the Ruby programming language that provides a standard format for distributing Ruby programs and libraries (in a self-contained format called a "gem"), a tool designed to easily manage the installation of gems, and a server for distributing them. More her : https://rubygems.org/


# Notes

Rbenv in some macOS versions (with ZSH) will need additional steps (credits to :  [Rod Wilhelmy](https://coderwall.com/wilhelmbot) ) : 
Moving rbenv initialization to ~/.zshenv : 
    ```
    $ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshenv
    $ echo 'eval "$(rbenv init -)"' >> ~/.zshenv
    $ echo 'source $HOME/.zshenv' >> ~/.zshrc
    $ exec $SHELL
    ```

# To Do

- [ ] update instructions
- [ ] run Kitchen test for Nginx in Vagrant VirtualBox
- [ ] update instructions

# Done

- [x] maker initial readme.
- [X] install rbenv
- [X] test rbenv - install KitchenCI
- [x] create first local test
- [x] create Packer box template with corresponding provision scripts
- [x] run box in Vagrant VirtualBox

