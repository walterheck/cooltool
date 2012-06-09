cooltool
========

Description
===========
CoolTool is a utility for people who need to puppetize existing debian or redhat servers. It allows for blueprinting an existing server (that needs to be puppetised), then comparing that result to the blueprint from a server created out of vagrant and a basebox with a puppet repository applied to it. 
This paves the way to automating testing for completeness of legacy server puppetising. 

Prerequisites
=============
3 servers:
* A server to run cooltool from, referred to as 'Ops'
* A server that we need to puppetise, referred to as the legacy system
* A vagrant box that serves as the base for puppetising, referred to as the basebox

On Ops:
-------
* ruby 1.8.7
* vagrant > 1.0
* virtualbox >= 4.0
* a git repo that can be accessed from both the legacy system as well as the basebox

On the legacy system:
---------------------
* Blueprint

On the base box:
----------------
* Blueprint
* Puppet agent

A usable base box for Debian Squeeze 6.0.4 64bit can be found here: http://olindata.com/downloads/squeeze64.box

Usage
=====
ops:~/cooltool --gitrepo <gitrepo> --basebox <vagrant.box> --puppetrepo <puppetrepopath> --legacysshhost <hostinsshconfigfile>
	
