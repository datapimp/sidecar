# the watcher is responsible for watching the file
# system for changes and then publishing those changes
# to a channel, where they will be handled by the appropriate
# handler
module Sidecar
  class Watcher
    attr_accessor :options
    def initialize options={}

    end
  end
end
