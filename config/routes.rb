Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    root 'homes#top'
  end
  
  scope module: :end_user do
    root 'homes#top'
  end

  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :categories, only: [:index, :create, :show, :update, :destroy]
      resources :talk_themes, only: [:index, :create, :show, :update, :destroy] do
        resource :like, only: [:show, :create, :destroy] do
          collection do
            get 'judge'
          end
        end
      end
      get 'like/ip' => 'likes#ip'
    end
  end
end
