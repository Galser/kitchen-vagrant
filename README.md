# kitchen-vagrant
Kitchen-vagrant test that checks the vagrant virtualbox box have nginx

Based on https://github.com/Galser/packer-nginx64

# Purpose

This repository contains Kitchen tests for [Vagrant BirtualBox with Nginx](https://github.com/Galser/packer-nginx64) that checks the fact that Nginx package installed inside the box.

For the detailed explanation on how to build basic box with Nginx please refer to [this README in the prototype repo](https://github.com/Galser/packer-nginx64/blob/master/README.md). 

# Instructions

- To download the copy of the code (*clone* in Git terminology) - go to the location of your choice (normally some place in home folder) and run in terminal; in case you are using alternative Git Client - please follow appropriate instruction for it and download(*clone*) [this repo](https://github.com/Galser/kitchen-vagrant.git). 
```
git clone https://github.com/Galser/kitchen-vagrant.git
```

- Previous step should create the folder that contains copy of repository. Default name is going to be the same as the name of repository e.g. `kitchen-vagrant`. Locate and open it.
```
cd kitchen-vagrant
```
- In order to run our tests we need an isolated Ruby environment, for this purpose we are going to install and use rbenv - tool that lets you install and run multiple versions of Ruby side-by-side. 
    - **On macOS use HomeBrew** (check [Technologies section](#technologies) for more details) to install rbenv.  Execute from command-line :
    ```
    brew install rbenv
    ```
        To succesfully utilize rbenv you will need also to make appropiate env changes :
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
    - **On Linux (Debian flavored)**:

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

- Install required Ruby version and choose it as default local. Run from command line : 
```
rbenv install 2.3.1
rbenv local 2.3.1
```
- Check that your settings are correct by executing :
```
rbenv versions
```
Output should like something like this : 
```
 system
* 2.3.1 (set by /Users/.../kitchen-vagrant/.ruby-version)
  2.6.0
```
Your output can list other versions also, due to the difference in environments, but the important part is that you should have that asterisk (*) symbol in front of the Ruby version 2.3.1 marking it as active at the current moment
- To simplify our life and to install required Ruby packages we are going to use **Ruby bundler** (See : https://bundler.io/ ). Let's install it. Execute : 
```
gem install bundler
```
- We going to use KitchenCI for our test, to install it and other required **Ruby Gems**, the repository comes with the [Gemfile](Gemfile) that list all that required. Run :
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
- In order to test we need to have Vagrant Box with Nginx created and everything that required provisioned. To do it run in command line : 
```
make
```
*Note : This will utilize [Makefile](Makefile) with all instructions that is prepared in this repo. Generally in the modern distributions you already have make command by default, if it is missing, you will need to check you OS documentation on the instructions how to install make. Often it will just require simple one or two commands.*

# How to test

- To prepare tests (run the VM), execute :
    ```
    bundle exec kitchen converge
    ```
    Output going to start with :
    ```
    -----> Starting Kitchen (v2.3.3)
    -----> Creating <default-bionic-nginx64>...
        Bringing machine 'default' up with 'virtualbox' provider...
        ==> default: Importing base box 'bionic-nginx64'...
    ```
    And in case of successful run the last 2 lines of output should be : 
    ```
        Finished converging <default-bionic-nginx64> (0m0.01s).
    -----> Kitchen is finished. (0m36.66s)
    ```
- Now to run the test execute : 
    ```
    bundle exec kitchen verify
    ```
    Output should looks like ths : 
    ```
    -----> Starting Kitchen (v2.3.3)
    -----> Setting up <default-bionic-nginx64-vbox>...
        Finished setting up <default-bionic-nginx64-vbox> (0m0.00s).
    -----> Verifying <default-bionic-nginx64-vbox>...
    verify_host_key: false is deprecated, use :never
        Loaded tests from {:path=>"....kitchen-vagrant.test.integration.default"} 

    Profile: tests from {:path=>"/.../kitchen-vagrant/test/integration/default"} (tests from {:path=>"....kitchen-vagrant.test.integration.default"})
    Version: (not specified)
    Target:  ssh://vagrant@127.0.0.1:2200

    System Package nginx
        ✔  should be installed

    Test Summary: 1 successful, 0 failures, 0 skipped
        Finished verifying <default-bionic-nginx64-vbox> (0m0.26s).
    ```
    And as you can see from output above - 1 test finished successfully, no errors, no failures. And if you have color-enabled console there should be a green check mark that 
    System package nginx - **should be installed**, e.g. we do have Nginx installed in our box.
- To destroy the VM and free resources, run "
    ```
    bundle exec kitchen destroy
    ```
    Output :
    ```
    -----> Starting Kitchen (v2.3.3)
    -----> Destroying <default-bionic-nginx64-vbox>...
        ==> default: Forcing shutdown of VM...
        ==> default: Destroying VM and associated drives...
        Vagrant instance <default-bionic-nginx64-vbox> destroyed.
        Finished destroying <default-bionic-nginx64-vbox> (0m4.54s).
    -----> Kitchen is finished. (0m6.69s)
    ```
- All of 3 step's above could be automated via running one command : 
    ```
    bundle exec kitchen test
    ```
This ends up the instructions, thank you. 


# Technologies

- **KitchenCI** - provides a test harness to execute infrastructure code on one or more platforms in isolation. FGor more details please check the productl site : [KitchenCI](https://kitchen.ci/)

- **Homebrew** - is atool for MacOS installs the stuff you need that Apple (or your Linux system) didn’t. Check in details and instruction how to install [here](https://brew.sh/)

- **RubyGems** is a package manager for the Ruby programming language that provides a standard format for distributing Ruby programs and libraries (in a self-contained format called a "gem"), a tool designed to easily manage the installation of gems, and a server for distributing them. More her : https://rubygems.org/


# To Do


# Done

- [x] make initial readme.
- [X] install rbenv
- [X] test rbenv - install KitchenCI
- [x] create first local test
- [x] create Packer box template with corresponding provision scripts
- [x] run box in Vagrant VirtualBox
- [x] update instructions
- [x] make KitchenCI tests for Nginx in Vagrant VirtualBox
- [x] create make file to simplify test for end-user
- [x] update instructions
