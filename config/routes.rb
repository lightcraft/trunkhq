Trunkhq::Application.routes.draw do
  resources :providers
  resources :prefix_groups
  resources :chan_groups

  root :to => 'home#index'
  match 'report' => 'home#report'

  match '/sys_log' => 'home#sys_log'

  match "/full_log" => proc { |env| [200, {}, code_wrapper('tail -100 /var/log/asterisk/full')] }
  match "/short_log" => proc { |env| [200, {}, code_wrapper('tail -100 /var/log/asterisk/full | grep VERBOSE')] }
  match "/show_channels" => proc { |env| [200, {}, code_wrapper("asterisk -x 'core show channels'")] }
  match "/show_peers" => proc { |env| [200, {}, code_wrapper("asterisk -x 'sip show peers'")] }

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

  resources :users, :only => [:show, :index] do
    resources :locations
    member do
      post 'grant'
      post 'switch'
    end
  end

  def code_wrapper(command)
    ["<pre class='prettyprint'>" + Time.now.to_s + (%x[#{command}]) + "</pre>" ]
  end

end
