Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root 'homes#top'
    resources :categories, only: [:index, :create, :edit, :update, :destroy]
  end
  
  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :categories, only: [:index, :create, :edit, :update, :destroy]
      resources :talk_themes, only: [:index]
    end
  end
end
