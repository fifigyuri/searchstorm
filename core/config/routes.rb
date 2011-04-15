
Rails.application.routes.draw do
  root :to => 'articles#search'
  resources :articles
  match "/search/:q" => "articles#search"
end
