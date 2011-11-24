module Sidecar
  def self.run options={}
    Sidecar::Server.new(options)
  end
end
