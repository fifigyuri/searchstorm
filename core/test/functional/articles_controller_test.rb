require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase

  setup do
    Article.delete_all
    Sham.reset
  end

  context "for logged in user" do

    context "on GET to show" do
      setup do
        article = Article.make
        get :show, :id => article.id
      end
      should respond_with :success
      should "have article value set" do
        assert_not_nil assigns(:article)
      end
      should render_template :show
    end

    context "on common search setup" do

      setup { Sunspot.remove_all! }

      context "on searching accented characters" do
        setup do
          2.times { Article.make }
          (Article::per_page + 1).times { Article.make(:accent_in_body) }
          Sunspot.commit
          get :search, :q => Sham.accented_word
        end
        should respond_with :success
        should "have articles value set" do
          articles = assigns(:articles)
          assert_not_nil assigns(:articles)
          assert_equal 1, articles.current_page
          assert_equal Article::per_page + 1, articles.total_entries
        end
        should render_template :search
      end
    end
  end
end

