Rails.application.routes.draw do
  # Authentications
  get    '/sign_up'  => 'authentications#new_sign_up', as: 'sign_up'
  get    '/sign_in'  => 'authentications#new_sign_in', as: 'sign_in'

  post   '/sign_up'  => 'authentications#sign_up'
  post   '/sign_in'  => 'authentications#sign_in'
  delete '/sign_out' => 'authentications#destroy', as: 'sign_out'

  # Passwords
  get '/reset_password'  => 'passwords#new_reset_password_instructions', as: 'reset_password_instructions'
  get '/password/:token' => 'passwords#new_reset_password', as: 'reset_password'

  post '/reset_password'  => 'passwords#reset_password_instructions'
  post '/password/:token' => 'passwords#reset_password'

  post '/webhooks' => 'webhooks#manage'

  # Dashboard
  resource :dashboard, only: [:show]
  # User
  resource :user, only: [:show] do
    get    :password, to: 'users#new_edit_password', as: 'new_edit_password'
    put    :password, as: 'edit_password'
    post   :subscribe
    delete :unsubscribe
  end

  # Torrent
  resources :torrents, only: [:create] do
    get :download, on: :member
  end

  # Landing/Static Pages
  root to: 'landing#index'

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
