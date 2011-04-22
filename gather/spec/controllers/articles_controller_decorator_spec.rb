require 'spec_helper'

describe ArticlesController do

  it 'renders scrapped page' do
    Sunspot::Indexer.stub!(:add_documents)
    Rails.application.scraping.should_receive(:gather_url).with('http://example.com').and_return([Factory.build(:article)])
    get :scrape, :page => 'http://example.com'
    response.should render_template :scrap
    # response.body.should == 'zazaaaaaa!!!'
  end

end
