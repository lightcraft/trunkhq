Trunkhq::Application.routes.draw do
  root :to => 'home#index'
  authenticated :user do
    root :to => 'home#index'
  end
  devise_for :users

  match 'location/:id' => 'locations#show'
  resources :locations do
    resources :trunks
  end

  resources :users, :only => [:show, :index]  do
    resources :locations
    member do
      post 'grant'
    end
  end

end
