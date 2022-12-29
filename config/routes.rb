Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    root 'homes#top'
    get 'content/new', to: 'homes#top'
    get '/categories/:id/edit', to: 'homes#top'
    get '/talk_themes/:id/edit', to: 'homes#top'
  end
  
  scope module: :end_user do
    root 'homes#top'
    get 'content', to: 'homes#top'
    get 'guide', to: 'homes#top'
  end

  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :categories, only: [:index, :create, :show, :update, :destroy]
      resources :talk_themes, only: [:index, :create, :show, :update, :destroy] do
        resource :like, only: [:show, :create, :destroy]
      end
      get 'like/ip' => 'likes#ip'
    end
  end

  if Rails.env.production?
    match "*path" , to: redirect('/'), via: 'get'
  end
end
