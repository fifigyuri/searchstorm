require 'spec_helper'

describe ArticlesController do
  render_views

  it 'renders scraped page' do
    Sunspot.session.stub!(:index)
    Rails.application.scraping.should_receive(:gather_url).with('http://example.com').
      and_return([Factory.create(:article, :title => 'Example Document Title')])

    visit articles_scrape_path :page => 'http://example.com'
    response.should render_template :scrap
    response.should be_success
    page.should have_content 'Example Document Title'
  end
end
