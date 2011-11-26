module Sidecar
  class Server
    attr_accessor :projects, :clients, :websocket

    def initialize options={}
      @websocket_server = Sidecar::Websocket.new()    
      @clients = []
      @projects = []
    end

  end
end
