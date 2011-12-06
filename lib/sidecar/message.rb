module Sidecar
  class Message
    attr_accessor :recipient, :content

    def initialize recipient, options={}
      @recipient = recipient
      @options = options
    end

    def send
    end
  end
end

