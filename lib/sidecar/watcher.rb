# the watcher is responsible for watching the file
# system for changes and then publishing those changes
# to a channel, where they will be handled by the appropriate
# handler
module Sidecar
  class Watcher
    attr_accessor :options, :project_root, :reactor
    
    def initialize options={}
      @project_root = File.expand_path( options[:project_root] )
      start
    end
    
    def start
      puts "Starting Watcher"
      EM.run {
        em_dir_watcher
      }
    end

    def em_dir_watcher
      @watcher ||= EMDirWatcher.watch(project_root, reactor_options) do |paths|
        paths.each do |path|
          if File.exists?(path) 
            puts "Modified: #{ path }"
          else
            puts "Deleted: #{ path }"
          end
        end
      end
    end

    def reactor_options
      {
        :include_only => ['*.html', '*.css', '*.js'],
        :exclude => ['~*', 'vendor/plugins'],
        :grace_period => 0.2
      }
    end

    def rails?
      gemfile_present? and IO.read( File.join(project_root,'Gemfile') ).match(/gem\s+['"]rails['"]/)
    end

    def gemfile_present? 
      File.exist?(File.join(project_root,'Gemfile'))
    end
  end
end
