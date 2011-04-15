require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  setup do
    Article.delete_all
    Sham.reset
  end

  context "for basic article tests" do

    should "create valid article" do
      assert_difference('Article.count') do
        article = Article.make
        assert article.valid?
      end
    end

    should "create invalid article, the URL is invalid" do
      article = Article.make_unsaved(:url => Sham.incorrect_url)
      assert !article.valid?
    end

    should "create duplicate article, should fail as the guid is the same" do
      article = Article.make
      article_duplicate = Article.make_unsaved(:guid => article.guid)
      assert !article_duplicate.valid?
    end

    should "modify valid article, should fail when the URL changed to invalid" do
      article = Article.make
      article.url = Sham.incorrect_url
      assert !article.valid?
    end

    should "be able to count size also for articles with nil fields" do
      article = Article.make(:title => nil, :summary => nil, :body => nil, :url => 'http://www.hophop.com/')
      assert article.size > 0
    end
  end

  context "for sunspot" do
    setup { Sunspot.remove_all! }

    context "on indexing and searching central-european characters" do
      setup do
        begin
          10.times { Article.make }
        rescue ActiveRecord::RecordInvalid => invalid
          debugger
          puts 'zaza'
        end
        [:accent_in_title, :accent_in_summary, :accent_in_body].each { |i| Article.make(i) }
        Sunspot.commit
      end
      should "find articles with accents" do
        search = Sunspot.search(Article) { keywords Sham.accented_word }
        assert_equal 3, search.results.count
      end
      should "find articles with no accents" do
        search = Sunspot.search(Article) { keywords Sham.unaccented_word }
        assert_equal 3, search.results.count
      end
    end

    context "on indexing characters prohibited in XML documents" do
      should "not raise expcetion" do
        assert_nothing_raised { Article.make(:with_corrupt_xml_chars) }
      end
    end
  end
end

