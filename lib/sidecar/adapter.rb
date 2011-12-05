module Sidecar
  class Adapter < Faye::RackAdapter
    def new(app = nil, options = nil)
      puts "Creating Sidecar Rack Adapter"

      if options.is_a?(Hash)
        options[:extensions] ||= []
        options[:extensions] << Sidecar::Handler.new
      end

      super(app, options)
    end
  end
end
