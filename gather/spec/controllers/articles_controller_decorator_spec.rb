require 'spec_helper'

describe ArticlesController do

  it 'renders scrapped page' do
    pending
    SearchstormGather::Scraping.should_receive(:do_page_blocks)
    SearchstormGather::Scraping.should_receive(:products_for).and_return([Object.new]) #[Factory.create(:article)])
    get :scrape, :page => 'http://example.com'
    response.should render_template :scrap
    # response.body.should contain 'zazaaaaaa!!!'
  end

end
