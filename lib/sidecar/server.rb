module Sidecar
  class Server
    attr_accessor :adapter, :options
    
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
      listen
    end

    def debug?
      options[:debug]
    end

  end
end
