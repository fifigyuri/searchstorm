
namespace :app do

  namespace :news do

    desc "Fetch new feed items from all infosources"
    task :update do
      puts `nohup ruby script/runner --environment=#{RAILS_ENV} "Infosource.fetch_all_sources" &`
    end

    desc "Mark news for approval"
    task :mark_for_approval do
      puts `nohup ruby script/runner --environment=#{RAILS_ENV} "User.mark_recent_news_for_approval_for_every_user" &`
    end

    desc "Post news fulfilling user's keywords"
    task :post do
      puts `nohup ruby script/runner --environment=#{RAILS_ENV} "User.post_recent_news_for_every_user" &`
    end
  end

=begin
  namespace :data do
    desc "Reindex the solr engine indices"
    task :reindex do
      puts `nohup ruby script/runner --environment=#{RAILS_ENV} "Article.reindex" &`
    end
  end
=end

end
