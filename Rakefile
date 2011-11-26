# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "sidecar"
  gem.homepage = "http://github.com/datapimp/sidecar"
  gem.license = "MIT"
  gem.summary = %Q{sidecar is a development utility for rails}
  gem.description = %Q{sidecar is a development utility for rails which runs tests, javascript, css, and ruby code}
  gem.email = "jonathan.soeder@gmail.com"
  gem.authors = ["Jonathan Soeder"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end
