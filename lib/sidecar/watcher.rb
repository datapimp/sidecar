# the watcher is responsible for watching the file
# system for changes and then publishing those changes
# to a channel, where they will be handled by the appropriate
# handler
module Sidecar
  class Watcher
    attr_accessor :options, :project_root, :reactor, :server
    
    def initialize options={}, server
      @project_root = File.expand_path( options[:project_root] )
      @server = server
    end
    
  end
end
