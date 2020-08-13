Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      resources :anketo, only: [:index, :show, :create, :update, :destroy]
      resources :comment, only: [:index, :show, :create, :update, :destroy]
      resources :vote, only: [:index, :create]
    end
  end
end
