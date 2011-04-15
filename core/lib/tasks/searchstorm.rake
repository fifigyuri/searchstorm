
namespace :searchstorm do

  desc "Loads the rails environment"
  task :rails_environment do
    require File.expand_path("#{Rails.root.to_s}/config/environment")
  end

  namespace :db do
    desc "Migrate the database through scripts in db/migrate and update db/schema.rb by invoking db:schema:dump. Target specific version with VERSION=x. Turn off output with VERBOSE=false."
    task :migrate do
      require File.expand_path("#{Rails.root.to_s}/config/environment")
      ActiveRecord::Migration.verbose = ENV['VERBOSE'] ? ENV['VERBOSE'] == "true" : true
      ActiveRecord::Migrator.migrate("#{File.dirname(__FILE__)}/../../db/migrate/",
                                     ENV['VERSION'] ? ENV["VERSION"].to_i : nil)
      Rake::Task["db:schema:dump"].invoke if ActiveRecord::Base.schema_format == :ruby
    end
  end
end
