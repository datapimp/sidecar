module Sidecar
  class Server
    attr_accessor :adapter, :options, :watcher
    
    def initialize options={}
      @options= options

      options[:mount] ||= "/sidecar"
      options[:port] ||= 9292 
      
      @adapter = Sidecar::Adapter.new(options)
      
      yield(self) if block_given?
    end
    
    def server
      this
    end
   
    def bind event, &block
      @adapter.bind event, &block
    end

    def listen
      @adapter.listen( options[:port] )
    end

    def start *args
      watch unless disable_watcher? 
      listen
    end
    
    def watch
      @watcher ||= Sidecar::Watcher.new( options )
    end
    
    def disable_watcher?
      options[:disable_watcher]
    end

    def debug?
      options[:debug]
    end

  end
end
