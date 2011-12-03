require 'sidecar/project'
require 'sidecar/websocket'
require 'sidecar/server'
require 'sidecar/command_socket'

module Sidecar
  def self.run options={}
    Sidecar::Server.new(options)
  end
end
