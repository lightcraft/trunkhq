Trunkhq::Application.routes.draw do

  resources :prefixes

    root :to => 'home#index'
  match 'location/:id' => 'locations#show'

  match '/sys_log' => 'home#sys_log'
  #match "/full_log" => proc { |env| [200, {}, code_wrapper('tail -100 /var/log/asterisk/full')] }
  match "/full_log" => proc { |env| [200, {}, code_wrapper("tail -100 /var/log/asterisk/full |awk -F DEBUG '{ print \"DEBUG:\"$2}'")] }
  match "/short_log" => proc { |env| [200, {}, code_wrapper('tail -100 /var/log/asterisk/full | grep VERBOSE')] }
  match "/show_channels" => proc { |env| [200, {}, code_wrapper("asterisk -x 'core show channels'")] }
  match "/show_peers" => proc { |env| [200, {}, code_wrapper("asterisk -x 'sip show peers'")] }

  resources :ivrs
  resources :black_lists
  resources :prefix_groups_for_providers
  resources :prefix_groups
  resources :chan_groups

  match '/report/(:id)' => 'home#report', as: :report

  resources :providers
  authenticated :user do
    root :to => 'home#index'
  end
  devise_for :users

  resources :locations do
    resources :channels do
      member do
        get 'power'
        get 'sys_info'
      end
    end
  end

  resources :users, :only => [:show, :index, :update] do
    resources :locations
    resources :friend_groups do
      get 'channels_assignment', on: :collection
      post 'assign_channels', on: :collection
    end
    member do
      post 'grant'
      post 'switch'
    end
  end

  def code_wrapper(command)
    ["<pre class='prettyprint'>" + Time.now.to_s + (%x[#{command}]) + "</pre>"]
  end

end
