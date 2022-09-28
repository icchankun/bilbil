Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :talk_themes, only: [:index, :create, :edit, :update, :destroy]
  end
end
