APP_PATH = File.join( Dir.getwd, 'config', 'application' )

module Sidecar
  class RailsLoader
    attr_accessor :options, :server

    def initialize options={}, server=nil
      @options = options
      @server = server

      load_environment!
    end
    
    def rails_loader
      self
    end

    def load_environment!
      Object.class_eval do
        require File.join( Dir.getwd, 'config', 'boot' )

        ENV['RAILS_ENV'] ||= 'development'

        require APP_PATH
        Rails.application.require_environment!
      end
    end
  end
end
