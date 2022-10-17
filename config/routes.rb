Rails.application.routes.draw do
  get 'posts/new'
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index login show create destroy update]
      resources :posts, only: %i[index show create destroy update]
      post '/validate/email',  to: 'validation#validate_email'
      post '/validate/name',    to: 'validation#validate_username'
      post '/auth/login',             to: 'authentication#login'
    end
  end
end
