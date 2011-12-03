module Sidecar
  class CommandSocket < EM::Protocols::LineAndTextProtocol
    def initialize
      puts "Initializing Sidecar Command Socket"
      @line_counter = 0
      @data_buffer = []
    end

    def receive_data data
      @data_buffer << data
      @line_counter += 1

      send_data @data_buffer.join() and reset if @line_counter == 10
    end

    private

    def reset
      @line_counter = 0
      @data_buffer = []
    end
  end
end
