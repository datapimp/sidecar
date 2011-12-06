require 'rubygems'
require 'bundler'

Bundler.require(:default)

require 'sidecar/adapter'
require 'sidecar/handler'
require 'sidecar/server'
require 'sidecar/client'
require 'sidecar/message'

module Sidecar
  VERSION = "0.0.1.alpha"

  def self.command arguments=[]
    Sidecar::Command.execute( arguments )
  end
  
  def self.quit

  end

  def self.listen options={}
    server=Sidecar::Server.new(options) do |sidecar|
      puts "Configuring Sidecar"
      # tap into the monitoring api for debugging purposes
      sidecar.bind(:publish) do |client_id, channel, data| 
        puts "#{ client_id } published to #{ channel }: #{ data }"
      end

      sidecar.bind(:subscribe) do |client_id, channel| 
        puts "client #{ client_id } subscribed to #{ channel }"
      end

      sidecar.bind(:connect) { puts "Client COnnected" }
      sidecar.bind(:disconnect) { puts "Client COnnected" }
    end

    server.listen()
  end
end
