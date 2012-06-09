#!/usr/bin/env ruby

require 'rubygems'
require 'net/ssh'
# require 'vagrant'

print "CoolTool\n"

legacyIp        = "192.168.56.201"
legacyUsername  = "root"
legacyPort      = 37923
legacyPassword  = "root"
# legacyKey = "/Users/olindata/.ssh/od-linode"

findHostNameCmd = "hostname"
# createBlueprintCmd = "blueprint create"

print "Connecting to Legacy box " + legacyIp + " using " + legacyUsername + "/" + legacyPassword + "\n"

# Connect to the legcy system
Net::SSH.start( legacyIp, legacyUsername, legacyPassword,
                :port     => legacyPort
                # :host_key => 'ssh-rsa',
                # :keys     => legacyKey
                ) do |ssh|
  print "Connected!\n"

  legacyHostname = (ssh.exec! findHostNameCmd).delete("\n")
  currentTimestamp = Time.now.strftime("%d%m%Y%H%M%S")
  #puts ssh.exec! findHostNameCmd
  blueprintName = legacyHostname + "-" + currentTimestamp
  # puts "" + legacyHostname + "-" + currentTimestamp
  
  blueprintCmd = createBlueprintCmd + " " + blueprintName
  # blueprintCmd = "uname -a"
  print blueprintCmd + "\n"
  
  print "Create blueprint repo" + "\n"
  # puts ssh.exec! blueprintCmd 
  
end

# # bring up the vagrant box
# task :up do
#   puts "About to run vagrant-up..."
#   env = Vagrant::Environment.new
#   env.cli("up")
#   puts "Finished running vagrant-up"
# end