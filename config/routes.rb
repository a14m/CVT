Rails.application.routes.draw do
  # resources :passwords, controller: 'clearance/passwords', only: [:create, :new]

  # resources :users, controller: 'clearance/users', only: [:create] do
    # resource :password, controller: 'clearance/passwords', only: [:create, :edit, :update]
  # end

  get    '/sign_up'  => 'authentications#new_sign_up', as: 'sign_up'
  post   '/sign_up'  => 'authentications#sign_up'
  get    '/sign_in'  => 'authentications#new_sign_in', as: 'sign_in'
  post   '/sign_in'  => 'authentications#sign_in'
  delete '/sign_out' => 'authentications#destroy',     as: 'sign_out'

  get '/dashboard' => 'dashboards#show'

  root to: 'dashboards#index'

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
