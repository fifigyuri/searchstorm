require 'searchstorm'
require 'searchstorm/preferences'

%w{ controllers helpers models views }.each do |dir|
  path = File.join(File.dirname(__FILE__), '..', 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.autoload_paths << path
  ActiveSupport::Dependencies.autoload_once_paths.delete(path)
end
