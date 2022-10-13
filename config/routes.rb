Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root 'homes#top'
    resources :categories, only: [:index, :create, :edit, :update, :destroy]
  end
  
  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :categories, only: [:index, :create, :show, :update, :destroy]
      resources :talk_themes, only: [:index, :create]
    end
  end
end
