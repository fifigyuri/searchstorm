require 'spec_helper'

describe ArticlesController do

  it 'renders scrapped page' do
    get :scrap, :page => 'http://example.com'
  end

end
