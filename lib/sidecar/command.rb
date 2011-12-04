module Sidecar
  class Command < Faye::Client
    attr_accessor :arguments

    def initialize arguments=[]
      @arguments = arguments
      super('http://localhost:9292/sidecar')
      
      execute
    end
    
    def runner
      self
    end
    
    def execute
      require 'eventmachine'
        
      reactor = EM

      reactor.run do 
        runner.publish("/blah", arguments)
        puts runner.state
      end
    end

    def self.execute arguments=[]
      new(arguments)
    end
  end
end
