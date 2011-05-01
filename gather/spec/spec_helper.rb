require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../test_app/config/environment", __FILE__)
  require 'rspec/rails'
  RSpec.configure do |c|
    c.mock_with :rspec
  end
end

Spork.each_run do
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
  Dir[File.join(File.dirname(__FILE__), "factories/**/*.rb")].each {|f| require f}
  Rails.application.scraping.url_seed = 'http://example.com'
end
