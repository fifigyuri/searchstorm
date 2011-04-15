# ecoding: utf-8

require 'anemone'
require 'nokogiri'
require 'open-uri'
require 'scrapi'
require 'htmlentities'

namespace :crawler do
  desc 'Start crawling of parameter.sk'
  task :parameter => :environment do
    parameter_arch_links = 'http://www.parameter.sk/archivum?page='
    coder = HTMLEntities.new
    Scraper::Base.parser :html_parser
    MATCHING_URLS = %r{^http://www\.parameter\.sk/archivum?page=\d+$|^http://www\.parameter\.sk/rovat/[a-z]+/\d{4}/\d{2}/\d{2}/[^?*/\(\);&\$\@\{\}]+$}

    #create inforsource for crawling
    # infosource_name = 'parameter_crawler'
    # parameter_infosource = Infosource.find_by_sourcename(infosource_name)
    # if !parameter_infosource
    #   parameter_infosource = Infosource.new
    #   parameter_infosource.attributes = { :sourcename => parameter_infosource, :sourcefeed => nil }
    #   parameter_infosource.save
    # end

    parameter_articles = Scraper.define do
      content_header = "div#content-header"
      content_area = "div#content-area div.node-inner"
      process "#{content_header} h1.title", :title=>:text
      process "#{content_area} div.bevezeto", :summary=>:text
      process "#{content_area} div.tartalom", :body=>:text
      process "#{content_area} div.tartalom p:last-child", :author=>:text
      process "#{content_area} div.submitted span.date", :published_at=>:text

      result :title, :summary, :body, :author, :published_at
    end

    felvidekma_articles = Scrapper.define do
      content_area = "#ja-content-main .item-page"
      process "#{content_area} > h1", :title => :text
      process "#{content_area} .article-tools dd.create", :published_at => :text
      process "#{content_area} .article-tools dd.createdby", :author => :text
      process "#{content_area} .article-content", :body => :text
    end

    # an = Anemone.crawl((0..3).map {|page| "#{parameter_arch_links}#{page}"}) do |anemone|
    an = Anemone.crawl("http://www.parameter.sk/archivum") do |anemone|
      anemone.storage = Anemone::Storage.MongoDB
      anemone.on_pages_like(%r{http://www.parameter.sk/rovat/[a-z]+/\d{4}/\d{2}/\d{2}/.+}) do |page|
        if page.url && (page.url.to_s !~ /%/)
          # debugger
          article_scrap = parameter_articles.scrape(page.body)
          parameter_publish_regexp = %r{(\d{4}), (.*) (\d{1,2}) - (\d{2}):(\d{2})}
          date_match = parameter_publish_regexp.match(article_scrap.published_at)
          link_s = page.url.to_s
          link_s = URI.unescape(link_s) while link_s =~ /%/
          puts link_s
          if date_match
            puts "#{article_scrap.published_at} # #{date_match[2]}"
            month = coder.decode(date_match[2])
            month_map = {'január'=>1, 'február'=>2, 'március'=>3, 'április'=>4,
              'május'=>5, 'június'=>6, 'július'=>7, 'augusztus'=>8, 'szeptember'=>9,
              'október'=>10, 'november'=>11, 'december'=>12 }

            article_data = {:full_page => page.body, :title => coder.decode(article_scrap.title).strip,
              :body => coder.decode(article_scrap.body).strip, :summary => coder.decode(article_scrap.summary).strip,
              :author => coder.decode(article_scrap.author).strip, :url => link_s,
              :published_at => DateTime.new(date_match[1].to_i, month_map[month], date_match[3].to_i,
                                            date_match[4].to_i, date_match[5].to_i)}

            article = Article.find_by_url(page.url) || Article.new
            article.attributes = article_data
            article.save
          else
            puts "SKIPPED #{link_s}"
          end
        end
      end

      anemone.focus_crawl do |page|
        links = page.links.select { |link| link.to_s =~ MATCHING_URLS }
        # fix strange URIs
        links.map do |link|
          link_s = link.to_s
          if link_s =~ /%/
            link_s = URI.unescape(link_s) while (link_s =~ /%/)
            URI(URI.escape(link_s))
          else
            link
          end
        end
        links.uniq
      end
    end
  end
end
