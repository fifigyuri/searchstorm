
Rails.application.class.class_eval do
  attr_accessor :scraping
end
Rails.application.scraping = SearchstormGather::Scraping.new
