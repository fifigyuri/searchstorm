
class GathererController < SearchstormController
  helper :articles

  def scrape
    @articles = Rails.application.crawler_builder.gather_url params[:page] { |product| product.instance_of? Article }
  end
end
