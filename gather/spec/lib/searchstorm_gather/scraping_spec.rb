require 'spec_helper'

describe SearchstormGather::Scraping do

  it 'creates crawler instance only when url seed is defined' do
    subject.crawler.should be_nil
    subject.url_seed = 'seedsite.com'
    subject.crawler.should_not be_nil
    subject.crawler.should be_instance_of Anemone::Core
  end

  it ( 'can store page scrapping products' ) { subject.products_for('foo').should == [] }
  it ( 'does not store nil key for scrapping products' ) { subject.products_for(nil).should be_nil }

  context 'with configured crawler' do

    before :each do
      subject.url_seed = 'example.com'
      subject.reset_crawler
    end

    let :matching_page do
      matching_page = mock('page with matching url')
      matching_page.stub!(:url).and_return('http://www.example.com/foo/hop')
      matching_page.stub!(:body).and_return(Faker::Lorem.paragraph)
      matching_page
    end

    it 'registers handler for url pattern' do
      page_handler_mock = mock('page handler')
      page_handler_mock.should_receive(:call).once.and_return('processes object')
      subject.on_pages_like(%r{http://www\.example\.com/foo/.*}) { page_handler_mock.call }
      subject.do_page_blocks(matching_page)
    end

    it 'returns a value after processing' do
      subject.on_pages_like(%r{http://www\.example\.com/foo/.*}) do |page|
        subject.products_for(matching_page) << 'product'
      end
      subject.do_page_blocks(matching_page)
      subject.products_for(matching_page).should == ['product']
    end

    context 'with scraped article' do
      before :each do
        @article_scrape_mock = mock('article data')
        article_attrs = {:title => Faker::Lorem.word, :summary => Faker::Lorem.paragraph, :body => Faker::Lorem.paragraph,
                         :author => Faker::Name.name, :published_at => Date.today}
        article_attrs.each_pair { |attr, value| @article_scrape_mock.stub!(attr).and_return(value) }
        @scraper_mock = mock('scraper')
        @scraper_mock.should_receive(:scrape).and_return(@article_scrape_mock)
      end

      it 'has a default processing method for registered scrapers' do
        subject.register_scraper(%r{http://www\.example\.com/foo/.*}, @scraper_mock)
        subject.do_page_blocks(matching_page)
        articles = subject.products_for(matching_page)
        articles.should be_kind_of Array
        [:title, :summary, :body, :published_at].each { |attr| articles.first.send(attr).should == @article_scrape_mock.send(attr) }
      end

      it 'allows to define a global product processing' do
        product_processor_mock = mock('product processor')
        product_processor_mock.should_receive(:call).once
        subject.set_product_processor do |page, product|
          product_processor_mock.call
          page.should == matching_page
          product.should be_kind_of Article
        end
        subject.register_scraper(%r{http://www\.example\.com/foo/.*}, @scraper_mock)
        subject.do_page_blocks(matching_page)
      end

      it 'handles the created product with a block if given' do
        product_process_mock = mock('product process')
        product_process_mock.should_receive(:call)
        subject.register_scraper(%r{http://www\.example\.com/foo/.*}, @scraper_mock) do |page, product|
          product.should be_an Article
          product_process_mock.call
        end
        subject.should_not_receive(:process_product)
        subject.do_page_blocks(matching_page)
      end

    end

    it 'registred scraper does not fail when nothing was scraped' do
      scraper_mock = mock('scraper')
      scraper_mock.should_receive(:scrape).and_return(nil)
      subject.register_scraper(%r{http://www\.example\.com/foo/.*}, scraper_mock)
      expect { subject.do_page_blocks(matching_page) }.should_not raise_error
    end
  end

  it 'collects products when scrapes page' do
    scraped_object = 'scraped product'
    subject.should_receive(:do_page_blocks)
    subject.should_receive(:products_for).and_return(['should be filtered out', scraped_object])
    page_body = <<PAGE
<html>
  <head><title>nice page to scrape</title></head>
  <body>with a cute content</body>
</html>
PAGE
    subject.should_receive(:open).with('http://justnews.com').and_return(StringIO.new(page_body))
    subject.gather_url('http://justnews.com') { |prod| prod =~ /product/ }.should == [scraped_object]
  end
end
