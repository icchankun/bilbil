Rails.application.routes.draw do
  namespace :admin do
    get 'categories/index'
  end
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :talk_themes, only: [:index, :create, :edit, :update, :destroy]
  end
  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :categories, only: [:index, :create, :edit, :update, :destroy]
    end
  end
end
