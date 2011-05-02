
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

    def process_product(page, product)
      products_for(page) << product
    end

    def gather_url(url, &condition)
      page = Anemone::Page.new(url, :body => open(url).read)
      do_page_blocks(page)
      products_for(page).select &condition
    end

    def register_scraper(url_pattern, scraper_class, &product_processor)
      crawler.on_pages_like(url_pattern) do |page|
        if page.url && (page.url.to_s !~ /%/)
          link_s = page.url.to_s
          link_s = URI.unescape(link_s) while link_s =~ /%/
          article_scrape = scraper_class.scrape(page.body)
          if article_scrape
            article_data = {:full_page => page.body, :url => link_s}
            [:title, :summary, :body, :author, :published_at].each { |attr| article_data[attr] = article_scrape.send(attr) }

            article = Article.find_by_url(page.url) || Article.new
            article.attributes = article_data
            if product_processor
              product_processor.yield page, article
            else
              process_product(page, article)
            end
          end
        end
      end
    end
  end
end
