#!/usr/bin/env ruby

require 'rubygems'
require 'net/ssh'
# require 'vagrant'

puts "CoolTool\n"

legacyIp        = "192.168.56.201"
legacyUsername  = "root"
legacyPassword  = "root"
legacyPort      = 37923

findHostNameCmd = "hostname"
createBlueprintCmd = "blueprint create"

puts "Connecting to Legacy box " + legacyIp + " using " + legacyUsername + "/" + legacyPassword 

# Connect to the legcy system
Net::SSH.start( legacyIp, legacyUsername, 
                :password => legacyPassword,
                :port     => legacyPort
                ) do |session|
  # Show we're connected
  puts "....Connected!\n"
  
  session.open_channel do |channel|

    legacyHostname = (session.exec! findHostNameCmd).delete("\n")
    currentTimestamp = Time.now.strftime("%d%m%Y%H%M%S")
    puts session.exec! findHostNameCmd
    blueprintName = legacyHostname + "-" + currentTimestamp
    # puts "" + legacyHostname + "-" + currentTimestamp
    
    blueprintCmd = createBlueprintCmd + " " + blueprintName
    print blueprintCmd + "\n"

    channel.exec(blueprintCmd) do |ch, success|
      abort "could not execute command" unless success

      channel.on_data do |ch, data|
        puts "got stdout: #{data}"
        channel.send_data "something for stdin\n"
      end

      channel.on_extended_data do |ch, type, data|
        puts "got stderr: #{data}"
      end

      channel.on_close do |ch|
        puts "channel is closing!"
      end
    end  

    # print "Create blueprint repo" + "\n"

  end

end

# # bring up the vagrant box
# task :up do
#   puts "About to run vagrant-up..."
#   env = Vagrant::Environment.new
#   env.cli("up")
#   puts "Finished running vagrant-up"
# end