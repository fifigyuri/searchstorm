ENV['RAILS_ENV'] = 'test'
require 'ruby-debug'
require "#{File.dirname(__FILE__)}/test_app/config/environment.rb"
require 'rails/test_help'

# require 'test_help'
require 'authlogic/test_case'
require 'mocha'
# require 'shoulda/action_controller'
require "#{File.dirname(__FILE__)}/blueprints"

class ActiveSupport::TestCase
  def login_as_test_user
    post
  end
end
