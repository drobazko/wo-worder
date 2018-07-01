Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"

  get '/words' => 'words#index', as: :words_index
  post '/words/count'
  post 'words/stat'
  get 'words/upload_list'

  root to: "words#index"

  get "/sales" => "sales#index", as: "sales_index"
  get "/sales/report" => "sales#report", as: "sales_report"
end
