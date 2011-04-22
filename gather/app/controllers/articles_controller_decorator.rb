
ArticlesController.class_eval do

  def scrape
    @articles = Rails.application.scraping.gather_url params[:page] do |product|
      product.instance_of?(Article)
    end
  end
end
