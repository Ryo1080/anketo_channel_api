Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      resources :anketo, only: [:index, :show, :create]
      resources :comment, only: [:index, :create]
      resources :vote, only: [:create]
    end
  end
end
