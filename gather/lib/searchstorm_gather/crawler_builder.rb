require 'active_support/core_ext/module/delegation'
require 'anemone'
require 'ref'
require 'open-uri'

module SearchstormGather

  class CrawlerBuilder
    delegate :do_page_blocks, :to => :crawler
    RECORDED_METHODS = [:after_crawl, :focus_crawl, :on_every_page, :on_pages_like, :skip_links_like]
    attr_accessor :url_seed

    def initialize(seed = nil)
      reset_crawler if url_seed = seed
      @scrapping_products = Ref::SoftKeyMap.new
      @registered_scrapers = []
      RECORDED_METHODS.each do |method_name|
        instance_variable_set "@#{method_name}_calls".to_sym, []
      end
    end

    def build
      return nil unless url_seed
      built_crawler = Anemone::Core.new(url_seed)
      @registered_scrapers.each do |url_pattern, scraper_class, product_processor|
        attach_scraper_to(built_crawler, url_pattern, scraper_class, &product_processor)
      end
      RECORDED_METHODS.each do |method_name|
        instance_variable_get("@#{method_name}_calls".to_sym).each do |*args, block|
          built_crawler.send(method_name, *args, &block)
        end
      end
      built_crawler
    end

    def crawler
      @crawler ||= build
    end

    def reset_crawler
      @crawler = nil
    end

    def products_for(key)
      return nil unless key
      return @scrapping_products[key] = [] unless @scrapping_products[key]
      @scrapping_products[key]
    end

    def process_product(page, product)
      products_for(page) << product
    end

    def set_product_processor &product_processor
      @product_processor = product_processor
    end

    def gather_url(url, &condition)
      page = Anemone::Page.new(url, :body => open(url).read)
      do_page_blocks(page)
      products_for(page).select &condition
    end

    def register_scraper(url_pattern, scraper_class, &product_processor)
      attach_scraper_to(crawler, url_pattern, scraper_class, &product_processor) if crawler
      @registered_scrapers << [url_pattern, scraper_class, product_processor]
      scraper_class
    end

    RECORDED_METHODS.each do |method_name|
      define_method method_name do |*args, &block|
        crawler.send(method_name, *args, &block) if crawler
        instance_variable_get("@#{method_name}_calls".to_sym) << [ *args, block ]
      end
    end

    private

    def attach_scraper_to(crawler, url_pattern, scraper_class, &product_processor)
      crawler.on_pages_like(url_pattern) do |page|
        if page.url && (page.url.to_s !~ /%/)
          link_s = page.url.to_s
          link_s = URI.unescape(link_s) while link_s =~ /%/
          article_scrape = scraper_class.scrape(page.body)
          if article_scrape
            article_data = {:full_page => page.body, :url => link_s}
            [:title, :summary, :body, :author, :published_at].each { |attr| article_data[attr] = article_scrape.send(attr) }

            article = Article.find_by_url(link_s) || Article.new
            article.attributes = article_data
            if product_processor
              product_processor.yield page, article
            elsif @product_processor
              @product_processor.yield page, article
            else
              process_product(page, article)
            end
          end
        end
      end
    end
  end
end
