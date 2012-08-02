Trankhq::Application.routes.draw do


  authenticated :user do
    root :to => 'home#index'
  end

  root :to => "home#index"
  devise_for :users
  resources :users, :only => [:show, :index]  do
    resources :locations
    member do
      post 'grant'
    end
  end
  match 'location/:id' => 'locations#show'
end
