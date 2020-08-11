Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      resources :anketo, only: [:create, :update, :destroy]
      resources :comment, only: [:create, :update, :destroy]
      resources :vote, only: [:create]
    end
  end
end
