
require 'anemone'
require 'ref'
require 'active_support/core_ext/module/delegation'
require 'open-uri'

module SearchstormGather

  class Scraping
    delegate :on_pages_like, :do_page_blocks, :to => :crawler

    attr_accessor :crawler, :url_seed

    def initialize(seed = nil)
      reset_crawler if url_seed = seed
      @scrapping_products = Ref::SoftKeyMap.new
    end

    def crawler
      @crawler ||= reset_crawler
    end

    def reset_crawler
      return nil unless url_seed
      @crawler = Anemone::Core.new(url_seed)
    end

    def products_for(key)
      return nil unless key
      return @scrapping_products[key] = [] unless @scrapping_products[key]
      @scrapping_products[key]
    end

    def gather_url(url, &condition)
      page = Anemone::Page.new(url, :body => open(url).read)
      do_page_blocks(page)
      products_for(page).select &condition
    end
  end
end
