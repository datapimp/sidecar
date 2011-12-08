module Sidecar
  class Server
    attr_accessor :adapter, :options, :watcher, :project_root
    
    def initialize options={}
      @options= options
      @project_root = options[:project_root]

      options[:mount] ||= "/sidecar"
      options[:port] ||= 9292 
      
      @adapter = Sidecar::Adapter.new(options)
      
      yield(self) if block_given?
    end
    
    def server
      this
    end
   
    def bind event, &block
      @adapter.bind event, &block
    end

    def listen
      @adapter.listen( options[:port] )
    end

    def start *args
      # mother fucking bundler, gemfile, rack conflicts in standalone mode.
      # rails unless disable_rails? 
      watch unless disable_watcher? 
      listen
    end
    
    def watch
      @watcher ||= Sidecar::Watcher.new( options, self )
    end

    def rails
      require 'sidecar/rails_loader' unless defined?(Sidecar::RailsLoader)
      @rails ||= Sidecar::RailsLoader.new( options, self )
    end
    
    def disable_rails?
      options[:disable_rails] or !rails?
    end

    def disable_watcher?
      options[:disable_watcher]
    end

    def debug?
      options[:debug]
    end

    def rails?
      gemfile_present? and IO.read( File.join(project_root,'Gemfile') ).match(/gem\s+['"]rails['"]/)
    end

    def gemfile_present? 
      File.exist?(File.join(project_root,'Gemfile'))
    end

  end
end
