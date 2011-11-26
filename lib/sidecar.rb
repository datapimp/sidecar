require 'sidecar/project'
require 'sidecar/websocket'
require 'sidecar/server'

module Sidecar
  def self.run options={}
    Sidecar::Server.new(options)
  end
end
