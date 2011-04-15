# encoding: utf-8

require 'sunspot'
require 'sunspot/rails'
require 'ruby-debug'

class Article < ActiveRecord::Base # include Sunspot::Rails::Searchable
  cattr_reader :per_page
  @@per_page = 10

  before_validation :remove_illegal_characters
  before_save :put_full_page_to_utf8

  alias_attribute :content, :body

  cattr_accessor :users_missing_after_reindex

  searchable do
    string :author
    text :title, :stored => true
    text :summary, :stored => true
    text :body, :stored => true
    string :url
    time :published_at
  end

  validates_format_of :url, :with => URI::regexp(%w(http https)), :allow_nil => true
  validates_uniqueness_of :guid, :allow_nil => true

  def self.standard_search
    Sunspot.new_search(Article) do
      order_by(:published_at, :desc)
    end
  end

  def size
    title.to_s.size + summary.to_s.size + body.to_s.size + url.to_s.size
  end

  def remove_illegal_characters
    ugly_characters = "\x00-\x1F"
    exchange_character = ' '
    self[:author] = author.tr(ugly_characters, exchange_character) unless author.nil?
    self[:title] = title.tr(ugly_characters, exchange_character) unless title.nil?
    self[:summary] = summary.tr(ugly_characters, exchange_character) unless summary.nil?
    self[:body] = body.tr(ugly_characters, exchange_character) unless body.nil?
    self[:url] = url.tr(ugly_characters, '') unless url.nil?
  end

  def put_full_page_to_utf8
    unless full_page.nil?
      self[:full_page] = Newscrapi::Encoding::get_html_doc_with_changed_encoding(full_page, 'utf-8').to_s
    end
  end
end
