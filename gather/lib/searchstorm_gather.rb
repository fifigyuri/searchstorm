#lib initialization code

require 'searchstorm_core'
require 'searchstorm_gather/scrapping'
require 'rails'

module SearchstormGather

  def self.version
    '0.0.6'
  end

  def self.base_directory
    File.expand_path(File.join(File.dirname(__FILE__), '..'))
  end

  class Engine < Rails::Engine
    initializer "scrappers" do |app|
      scrappers_dir = "#{Rails.root}/config/scrappers"
      Dir.entries(scrappers_dir).select { |f| f =~ /^.*\.rb$/}.each do |scrapper|
        load "#{scrappers_dir}/#{scrapper}"
      end if Dir.exists?(scrappers_dir)
    end
  end
end

