module Sidecar
  class Handler
    def incoming(message, callback)
      callback.call(message)
    end

    def outgoing(messgae, callback)
      callback.call(message)
    end
  end
end
