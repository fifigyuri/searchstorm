require 'rspec'
require 'shoulda'
require 'ruby-debug'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'searchstorm_gather'

Rspec.configure do |c|
  c.mock_with :rspec
end
