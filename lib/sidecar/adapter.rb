module Sidecar
  class Adapter < Faye::RackAdapter
    def initialize(app = nil, options = nil)
      @app      = app if app.respond_to?(:call)
      @options  = [app, options].grep(Hash).first || {}
 
      @options[:extensions] ||= []
      @options[:extensions] << Sidecar::Handler.new(options)

      super(app, @options)
    end
  end
end
