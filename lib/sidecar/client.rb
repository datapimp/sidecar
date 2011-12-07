require 'eventmachine'

module Faye
  class Client
    def publish(channel, data)
      unless Grammar::CHANNEL_NAME =~ channel
        raise "Cannot publish: '#{channel}' is not a valid channel name"
      end
      
      publication = Publication.new
      connect {
        info('Client ? queueing published message to ?: ?', @client_id, channel, data)
        
        send({
          'channel'   => channel,
          'data'      => data,
          'clientId'  => @client_id
        }) do |response|
          if response['successful']
            yield('success',nil) if block_given?
            publication.set_deferred_status(:succeeded)
          else
            yield('error', Error.parse(response['error'])) if block_given?
            publication.set_deferred_status(:failed, Error.parse(response['error']))
          end
        end
      }
      publication
    end
  end
end

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
        client.faye.publish(channel, message) do |status, err|
          reactor.stop
        end
      end
    end
  end
end
