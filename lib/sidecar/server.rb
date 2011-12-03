module Sidecar
  class Server
    attr_accessor :projects, :clients, :websocket, :command_socket

    def initialize options={}
      #@websocket_server = Sidecar::Websocket.new()    
      @clients = []
      @projects = []

      open_command_socket()
    end

    def open_command_socket()
      puts "Attempting to open command socket"
      EventMachine::run {
        EventMachine::start_server "127.0.0.1", 8080, Sidecar::CommandSocket
      }
    end

  end
end
