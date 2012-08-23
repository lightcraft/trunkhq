Trunkhq::Application.routes.draw do
  root :to => 'home#index'
  match 'report' => 'home#report'

  authenticated :user do
    root :to => 'home#index'
  end
  devise_for :users

  match 'location/:id' => 'locations#show'
  resources :locations do
    resources :channels do
      member do
        get 'power'
        get 'sys_info'
      end
    end
  end

  resources :users, :only => [:show, :index]  do
    resources :locations
    member do
      post 'grant'
    end
  end

end
