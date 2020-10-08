Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      get 'anketo/search', to: 'anketo#search'
      resources :anketo, only: [:show, :create, :destroy] do
        resources :comment, only: [:index, :create]
      end
      resources :vote, only: [:create]
    end
  end
end
