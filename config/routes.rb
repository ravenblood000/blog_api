Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "articles#index"

  get "/articles/:id/addviews/:views", to: "articles#addViews"
  get "/articles/:id/readviews/:views", to: "articles#readViews"

  resources :articles do
    resources :comments
  end
end
