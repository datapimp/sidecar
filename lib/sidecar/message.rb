module Sidecar
  class Message
    attr_accessor :options, :channel, :message_type

    def initialize options={} 
      @options = options
      @channel = options[:channel]
      @message_type = options[:message_type]

      route
      send
    end
    
    def message
      self
    end

    def send
      if send_to_server?
        server.send( message_type )
      else
        client.send( channel, message_type, options )
      end
    end
    
    protected

    def debug?
      options[:debug]
    end

    def route
      self.channel ||= "client"

      if channel == "start"
        self.channel= "server"
        self.message_type= "start"
      end

      if channel == "server" and %w{stop start}.include? message_type
        self.message_type = "start"
      end
    end
    
    def client
      @client ||= Sidecar::Client.new( options ) 
    end

    def server
      @server ||= Sidecar::Server.new( options ) do |server|
        if message.debug?
          server.bind(:publish) do |client_id, channel_id, message|
            puts "Client Id #{ client_id } #{ channel_id } #{ message.inspect }" 
          end
        end
      end
    end

    def send_to_server?
      channel == "server" || (channel == "start" or channel == "stop")
    end
  end
end

