# kitchen-vagrant
Kitchen-vagrant test that checks the vagrant virtualbox box have nginx

Based on https://github.com/Galser/packer-nginx64

# Purpose

This repository contains Kitchen tests for [Vagrant BirtualBox with Nginx](https://github.com/Galser/packer-nginx64) that checks the fact that Nginx is indeed installed.

For the notes on how to build basic box with Nginx please refer to [this README in the prototype repo](https://github.com/Galser/packer-nginx64/blob/master/README.md). 

# Instructions
- Install rbenv
- Install KitchenCI

# Technologies

- KitchenCI - provides a test harness to execute infrastructure code on one or more platforms in isolation. FGor more details please check the productl site : [KitchenCI](https://kitchen.ci/)

# To Do

- [ ] install rbenv
- [ ] test rbenv - install KitchenCI
- [ ] create first local test
- [ ] create Packer box template with corresponding provisoin scripts
- [ ] run box in Vagrant VirtualBox
- [ ] update instructions
- [ ] run Kitchen test for Nginx in Vagrant VirtualBox
- [ ] update instructions

# Done

- [x] maker initial readme.
