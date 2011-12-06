module Sidecar
  class Handler
    attr_accessor :options

    def initialize options={}
      puts "Creating Sidecar Handler #{ options.inspect }" if debug?
      @options = options
    end

    def incoming(message, callback)
      if debug?
        puts "Incoming"
        puts message.inspect
      end

      callback.call(message)
    end

    def outgoing(messgae, callback)
      if debug?
        puts "Outoing"
        puts message.inspect
      end

      callback.call(message)
    end

    def debug?
      options[:debug]
    end
  end
end
