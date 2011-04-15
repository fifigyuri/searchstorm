require 'sunspot'
require 'sunspot/rails'

class ArticlesController < SearchstormController

  def show
    @article = Article.find(params[:id])
  end

  def search
    page = (params[:page] || 1).to_i
    if params[:q]
      query = params[:q]
      search = Article.standard_search.build do
        keywords query do
          fields :title, :summary, :body
          highlight :title, :summary, :fragment_size => 0
        end
        paginate :page => page
      end
      search.execute
      @articles = search.hits
    end
  end

end
