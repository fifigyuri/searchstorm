class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :author
      t.text :title
      t.text :summary
      t.text :body
      t.string :url
      t.text :full_page, { :default => nil, :null => true }
      t.date :published_at
      t.string :guid

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
