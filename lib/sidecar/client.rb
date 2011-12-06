module Sidecar
  class Client
    attr_accessor :faye

    def initialize options={}
      @faye = Faye::Client.new("http://localhost:9292/sidecar")
    end

    def method_missing m, *args
      puts "m = #{ m }" 
      puts args.inspect
    end
  end
end
