require 'rubygems'
require 'bundler'
require 'faye'

require 'sidecar/server'
require 'sidecar/command'

module Sidecar
  def self.command arguments=[]
    Sidecar::Command.execute( arguments )
  end
  
  def self.quit

  end

  def self.listen options={}
    Sidecar::Server.new(options) do |sidecar|
      puts "Starting Sidecar..."
    end
  end
end
