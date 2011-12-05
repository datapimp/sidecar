require 'eventmachine'

# http://www.ruby-doc.org/stdlib/libdoc/optparse/rdoc/classes/OptionParser.html
require 'optparse'

module Sidecar
  class Command < Faye::Client
    attr_accessor :arguments, :command, :command_options, :assets

    def initialize arguments=[]
      @command = arguments.shift
      @arguments = arguments
      
      @command_options = parse_arguments(command_options)

      super("http://localhost:9292/sidecar") if client_required?

      run
    end

    def runner
      self
    end

    def reactor
      EM
    end

    def run
      if command == "start"
        Sidecar.listen
        exit
      end

      execute_command
    end

    def client_required?
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

    def parse_arguments(options)
      OptionParser.new do |parser|
        parser.banner = "Usage: sidecar [command] [options]"
        
        parser.on('-v','--version','Display the version') do 
          puts Sidecar::VERSION
          exit
        end
        
        parser.on("-t", "--force-type", "force the type of asset") do |o|
          command_options[:force_type] = o 
        end

        parser.on_tail('-h', '--help', "You're looking at it.") do
          puts parser
          exit
        end
      end
    end

    def self.execute arguments=[]
      new(arguments)
    end
  end
end
