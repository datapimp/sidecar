require 'eventmachine'

module Sidecar
  class Client
    attr_accessor :faye

    def initialize options={}
      @faye = Faye::Client.new("http://localhost:9292/sidecar")
    end

    def client
      self
    end
    
    def load assets, options={}
      assets = options[:contents] || assets
      publish("/assets", assets )
    end
    
    def reactor
      EM
    end

    def publish channel, message
      reactor.run do
        client.faye.publish(channel, message)
      end
    end
  end
end
