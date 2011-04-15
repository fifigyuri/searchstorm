
module SearchStorm

  def self.version
    '0.1.2'
  end

  def self.base_directory
    File.expand_path(File.join(File.dirname(__FILE__), '..'))
  end

  class Engine < Rails::Engine
    initializer "static assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end
  end
end

