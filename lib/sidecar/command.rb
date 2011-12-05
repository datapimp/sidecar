require 'eventmachine'

module Sidecar
  class Command < Faye::Client
    attr_accessor :arguments

    def initialize arguments=[]
      @arguments = arguments
      super('http://localhost:9292/sidecar')
      sleep(2)
      execute
    end

    def runner
      self
    end

    def reactor
      EM
    end

    def execute
      reactor.run do
        runner.publish("/blah", "ruby client")
        runner.publish("/blah", arguments )
      end
    end

    def self.execute arguments=[]
      new(arguments)
    end
  end
end
