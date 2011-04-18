# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{searchstorm_core}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gyorgy Frivolt"]
  s.date = %q{2011-04-19}
  s.description = %q{Have a search motor built on the top of Solr, a highly customizable, scalable and well performing search engine. You are only few steps away from creating your own search motor.}
  s.email = %q{gyorgy.frivolt@gmail.com}
  s.files = [
    "Gemfile",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "app/controllers/articles_controller.rb",
    "app/controllers/searchstorm_controller.rb",
    "app/helpers/articles_helper.rb",
    "app/helpers/layout_helper.rb",
    "app/helpers/site_helper.rb",
    "app/models/article.rb",
    "app/views/articles/_article.html.haml",
    "app/views/articles/_article_line.html.haml",
    "app/views/articles/_result_summary.html.haml",
    "app/views/articles/_search_form.html.haml",
    "app/views/articles/search.html.haml",
    "app/views/articles/show.html.haml",
    "app/views/layouts/searchstorm_application.html.haml",
    "app/views/shared/_navigation_bar.html.haml",
    "app/views/shared/_system_notify.html.haml",
    "config/initializers/jquery.rb",
    "config/locales/hu.yml",
    "config/locales/sk.yml",
    "config/routes.rb",
    "db/migrate/20090812102300_create_articles.rb",
    "lib/searchstorm_core.rb",
    "lib/tasks/app.rake",
    "lib/tasks/searchstorm.rake",
    "public/images/accept_button.jpg",
    "public/images/delete.jpg",
    "public/images/grid.png",
    "public/images/header_image.png",
    "public/images/login_header_image.png",
    "public/images/rails.png",
    "public/images/reject_button.jpg",
    "public/images/search_btn.gif",
    "public/javascripts/jquery.js",
    "public/javascripts/jquery.min.js",
    "public/javascripts/less-1.0.41.min.js",
    "public/javascripts/rails.js",
    "public/stylesheets/_articles.less",
    "public/stylesheets/_base.less",
    "public/stylesheets/_error_notices.less",
    "public/stylesheets/_forms.less",
    "public/stylesheets/_pagefooter.less",
    "public/stylesheets/_pageheader.less",
    "public/stylesheets/_pagination.less",
    "public/stylesheets/_tables.less",
    "public/stylesheets/screen.less",
    "searchstorm_core.gemspec",
    "test/blueprints.rb",
    "test/blueprints/articles.rb",
    "test/content_scrapper.rb",
    "test/functional/articles_controller_test.rb",
    "test/test_app/.gitignore",
    "test/test_app/Gemfile",
    "test/test_app/README",
    "test/test_app/Rakefile",
    "test/test_app/app/controllers/application_controller.rb",
    "test/test_app/app/helpers/application_helper.rb",
    "test/test_app/app/views/layouts/application.html.erb",
    "test/test_app/config.ru",
    "test/test_app/config/application.rb",
    "test/test_app/config/boot.rb",
    "test/test_app/config/database.yml",
    "test/test_app/config/environment.rb",
    "test/test_app/config/environments/development.rb",
    "test/test_app/config/environments/production.rb",
    "test/test_app/config/environments/test.rb",
    "test/test_app/config/initializers/backtrace_silencers.rb",
    "test/test_app/config/initializers/inflections.rb",
    "test/test_app/config/initializers/mime_types.rb",
    "test/test_app/config/initializers/secret_token.rb",
    "test/test_app/config/initializers/session_store.rb",
    "test/test_app/config/locales/en.yml",
    "test/test_app/config/routes.rb",
    "test/test_app/config/sunspot.yml",
    "test/test_app/db/schema.rb",
    "test/test_app/db/seeds.rb",
    "test/test_app/doc/README_FOR_APP",
    "test/test_app/lib/tasks/.gitkeep",
    "test/test_app/public/404.html",
    "test/test_app/public/422.html",
    "test/test_app/public/500.html",
    "test/test_app/public/favicon.ico",
    "test/test_app/public/images/rails.png",
    "test/test_app/public/javascripts/application.js",
    "test/test_app/public/javascripts/controls.js",
    "test/test_app/public/javascripts/dragdrop.js",
    "test/test_app/public/javascripts/effects.js",
    "test/test_app/public/javascripts/prototype.js",
    "test/test_app/public/javascripts/rails.js",
    "test/test_app/public/robots.txt",
    "test/test_app/public/stylesheets/.gitkeep",
    "test/test_app/script/rails",
    "test/test_app/vendor/plugins/.gitkeep",
    "test/test_helper.rb",
    "test/test_pages/short_full_page_extraction.html",
    "test/unit/article_test.rb"
  ]
  s.homepage = %q{http://github.com/fifigyuri/searchstorm}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{Searching made so simple that it is even a fun}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["~> 3.0.5"])
      s.add_runtime_dependency(%q<haml>, [">= 0"])
      s.add_runtime_dependency(%q<will_paginate>, [">= 0"])
      s.add_runtime_dependency(%q<sunspot>, ["~> 1.2.1"])
      s.add_runtime_dependency(%q<sunspot_rails>, ["~> 1.2.1"])
      s.add_development_dependency(%q<ruby-debug19>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<ffaker>, [">= 0"])
      s.add_development_dependency(%q<machinist>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
    else
      s.add_dependency(%q<rails>, ["~> 3.0.5"])
      s.add_dependency(%q<haml>, [">= 0"])
      s.add_dependency(%q<will_paginate>, [">= 0"])
      s.add_dependency(%q<sunspot>, ["~> 1.2.1"])
      s.add_dependency(%q<sunspot_rails>, ["~> 1.2.1"])
      s.add_dependency(%q<ruby-debug19>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<ffaker>, [">= 0"])
      s.add_dependency(%q<machinist>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, ["~> 3.0.5"])
    s.add_dependency(%q<haml>, [">= 0"])
    s.add_dependency(%q<will_paginate>, [">= 0"])
    s.add_dependency(%q<sunspot>, ["~> 1.2.1"])
    s.add_dependency(%q<sunspot_rails>, ["~> 1.2.1"])
    s.add_dependency(%q<ruby-debug19>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<ffaker>, [">= 0"])
    s.add_dependency(%q<machinist>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
  end
end

