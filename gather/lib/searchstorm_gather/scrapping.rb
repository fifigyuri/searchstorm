
require 'anemone'
require 'active_support/core_ext/module/delegation'

module SearchstormGather

  class Scrapping
    delegate :on_pages_like, :do_page_blocks, :to => :crawler

    attr_accessor :crawler, :url_seed

    def initialize(seed = nil)
      reset_crawler if url_seed = seed
    end

    def crawler
      @crawler ||= reset_crawler
    end

    def reset_crawler
      return nil unless url_seed
      @crawler = Anemone::Core.new(url_seed)
    end
  end
end
