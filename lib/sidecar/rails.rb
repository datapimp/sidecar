# this will mount the rails application and then
# run an event loop, evaluating any code which is
# published to the rails channel and outputting
# the results / publishing the results to the rails
# channel
require 'eventmachine'

APP_PATH = File.expand_path('../../config/application',  __FILE__)
require File.expand_path('../../config/boot',  __FILE__)

ENV["RAILS_ENV"] ||= "development" 

require APP_PATH
Rails.application.require_environment!

EM.run do
  begin
    if code_or_file.nil?
      exit 1
    elsif File.exist?(code_or_file)
      $0 = code_or_file
      eval(File.read(code_or_file), nil, code_or_file)
    else
      eval(code_or_file)
    end
  ensure
    if defined? Rails
      Rails.logger.flush if Rails.logger.respond_to?(:flush)
    end
  end
end
