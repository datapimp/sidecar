module Sidecar
  class Command
    attr_accessor :arguments, :command, :options, :assets, :client

    def initialize options={} 
      @options = {}
      @command = options[:command]
      @client = Faye::Client.new("http://localhost:9292/sidecar") unless client_not_required?

      execute_command
    end

    def runner
      self
    end

    def reactor
      EM
    end

    def client_not_required?
      !%w{start}.include? command
    end

    def channel
      "/#{ command }"
    end

    def execute_command
      reactor.run do
        runner.publish( channel, command_options )
      end
    end

    def self.execute arguments=[]
      new(arguments)
    end
  end
end
