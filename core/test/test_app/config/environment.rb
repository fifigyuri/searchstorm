# Load the rails application
require File.expand_path('../application', __FILE__)

if (RUBY_VERSION == '1.9.2')
  Encoding.default_internal = 'utf-8'
  Encoding.default_external = 'utf-8'
end

# Initialize the rails application
TestApp::Application.initialize!
