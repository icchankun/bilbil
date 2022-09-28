Rails.application.routes.draw do
  namespace :admin do
    namespace :api do
      namespace :v1 do
        get 'categories/index'
      end
    end
  end
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :talk_themes, only: [:index, :create, :edit, :update, :destroy]
  end
end
