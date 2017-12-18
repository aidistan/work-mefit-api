Rails.application.routes.draw do
  namespace :login do
    get  'oauth/authorize'
    post 'oauth/authorize'
    post 'oauth/access_token'
  end

  resources :users, only: %i[show update], shallow: true do
    resources :measurements
  end
end
