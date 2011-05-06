require 'spec_helper'

describe GathererController, 'page gatherer' do
  render_views

  it 'renders scraped page' do
    Sunspot.session.stub!(:index)
    Rails.application.crawler_builder.should_receive(:gather_url).with('http://example.com').
      and_return([Factory.build(:article, :title => 'Example Document Title')])

    visit gatherer_scrape_path :page => 'http://example.com'
    response.should render_template :scrap
    response.should be_success
    page.should have_content 'Example Document Title'
  end
end
