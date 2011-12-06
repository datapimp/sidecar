require 'optparse'

module Sidecar
  class CommandLine
    BANNER = <<-EOS
Usage sidecar [command] [options] 

Sidecar is a development utility which you run 
alog side your Rails application and Text Editor 
to respond to changes in your source code and asset
pipeline.

Changes will be pushed to any connected browser which depends
on the assets which have changed.  Sidecar also provides a gateway
between your app and your text editor, so you can preview changes
in rails console or web browser. 

Options:
  EOS

    def initialize
      parse_options
      Sidecar::Message.new(@options)
    end

    def parse_options
      @options = {
        :message_type   => nil,
        :contents       => nil,
        :config_path    => nil,
        :base_url       => nil,
        :root_directory => nil,
        :channel        => "client"
      }

      @option_parser = OptionParser.new do |opts|
        opts.on('-r','--root',)
        opts.on('-d','--debug','Enable debugging mode') do
          @options[:debug] = true
        end

        opts.on('-c','--config PATH','Path to sidecar.yml') do |config_path|
          @options[:config_path] = config_path
        end

        opts.on('-a', '--assets LIST','List of files to evaluate in the target environment') do |assets|
          @options[:contents] = assets
        end

        opts.on_tail('-v','--version','display Sidecar version') do
          puts "Sidecar version #{Sidecar::VERSION}"
          exit
        end
      end
      
      arguments = ARGV.dup
      
      @options[:channel] = arguments[0]
      @options[:message_type] = arguments[1]

      @option_parser.banner = BANNER
      @option_parser.parse!(arguments)
    end
  end
end
