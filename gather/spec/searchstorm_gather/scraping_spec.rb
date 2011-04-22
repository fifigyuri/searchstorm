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
  end

  it 'collects products when scrapes page' do
    scraped_object = 'scraped product'
    subject.should_receive(:do_page_blocks)
    subject.should_receive(:products_for).and_return(['should be filtered out', scraped_object])
    subject.gather_url('example.com') { |prod| prod =~ /product/ }.should == [scraped_object]
  end
end
