
ArticlesController.class_eval do

  def scrape
    SearchstormGather::Scraping.do_page_blocks(6)
    SearchstormGather::Scraping.products_for(6)
  end
end
