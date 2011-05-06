require 'rubygems'
require 'spork'

ENV["RAILS_ENV"] = 'test'

Spork.prefork do
  require File.expand_path("../test_app/config/environment", __FILE__)
  require 'rspec/rails'

  if Spork.using_spork?
    ActiveSupport::Dependencies.clear
    ActiveRecord::Base.instantiate_observers
  end

  RSpec.configure do |c|
    c.mock_with :rspec
  end
end

Spork.each_run do
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| load f}
  Factory.factories.clear
  Dir["#{File.dirname(__FILE__)}/factories/**/*.rb"].each{|f| load f}

  Rails.application.reload_routes!

  sporkfile = File.expand_path('../Sporkfile.rb', __FILE__)
  load sporkfile if File.exists?(sporkfile)

  Rails.application.crawler_builder.url_seed = 'http://example.com'
end
