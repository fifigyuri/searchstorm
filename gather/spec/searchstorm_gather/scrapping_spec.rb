require 'spec_helper'

describe SearchstormGather::Scrapping do

  it 'creates crawler instance only when url seed is defined' do
    subject.crawler.should be_nil
    subject.url_seed = 'seedsite.com'
    subject.crawler.should_not be_nil
    subject.crawler.should be_instance_of Anemone::Core
  end

  context 'with configured crawler' do

    before :each do
      subject.url_seed = 'example.com'
      subject.reset_crawler
    end

    it 'registers handler for url pattern' do
      page_handler_mock = mock('page handler')
      page_handler_mock.should_receive(:call).once
      subject.on_pages_like(%r{http://www.example.com/foo/.*}) { page_handler_mock.call }
      matching_page = mock('page with matching url')
      matching_page.stub!(:url).and_return('http://www.example.com/foo/hop')
      subject.do_page_blocks(matching_page)
    end
  end
end
