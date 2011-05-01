#lib initialization code

require 'searchstorm_core'
require 'searchstorm_gather/scraping'
require 'rails'

module SearchstormGather

  def self.version
    '0.0.6'
  end

  def self.base_directory
    File.expand_path(File.join(File.dirname(__FILE__), '..'))
  end

  class Engine < Rails::Engine
    initializer "load decorations" do |app|
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
    end

    initializer "scrappers" do |app|
      Rails.application.class.class_eval do
        attr_accessor :scraping
      end
      Rails.application.scraping = SearchstormGather::Scraping.new

      scrappers_dir = "#{Rails.root}/config/scrapers"
      Dir.entries(scrappers_dir).select { |f| f =~ /^.*\.rb$/}.each do |scrapper|
        load "#{scrappers_dir}/#{scrapper}"
      end if Dir.exists?(scrappers_dir)
    end
  end
end

