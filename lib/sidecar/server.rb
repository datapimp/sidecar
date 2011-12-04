module Sidecar
  class Server
    attr_accessor :adapter, :options
    
    def initialize options={}
      @options= options

      options[:mount] ||= "/sidecar"
      options[:port] ||= 9292 

      @adapter = Faye::RackAdapter.new(:mount => options[:mount], :timeout => 25)
      
      yield self if block_given?

      bindings
      listen
    end
    
    protected
    
    
    def server
      this
    end
    
    def on_asset client_id=nil, data=nil
      puts "On Asset. #{ client_id } #{ data }"
    end
  
    def on_publish channel, client_id=nil, data=nil
      if @callbacks[channel] and @callbacks[channel].respond_to?(:call)
        @callbacks[channel].call( client_id, data )
      end
    end

    def bindings
      bind(:publish) do |client_id, channel, data| 
        puts "#{ client_id } #{ channel } #{ data }"
        channel.gsub! /^\//, '' 
        server.respond_to?("on_#{ channel }") ? server.send("on_#{ channel }", client_id, data) : server.send("on_publish",channel, client_id, data)
      end

      bind :disconnect do
        puts "disconected"
      end
    end
    
    def bind event, &block
      @adapter.bind event, &block
    end

    def listen
      @adapter.listen( options[:port] )
    end
  end
end
