module Sidecar
  class Server
    attr_accessor :adapter, :options
    
    def initialize options={}
      @options= options

      options[:mount] ||= "/sidecar"
      options[:port] ||= 9292 
      
      @adapter = Faye::RackAdapter.new(:mount => options[:mount], :timeout => 25 )

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
  end
end
