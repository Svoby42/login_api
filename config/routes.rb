Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show create destroy update]
    end
  end
end
