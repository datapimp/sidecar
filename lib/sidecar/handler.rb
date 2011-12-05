module Sidecar
  class Handler
    def initialize
       puts "Initializing Sidecar Handler"
    end

    def incoming(message, callback)
      callback.call(message)
    end

    def outgoing(messgae, callback)
      callback.call(message)
    end
  end
end
