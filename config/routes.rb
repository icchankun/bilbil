Rails.application.routes.draw do
  namespace :admin do
    get 'talk_themes/index'
  end
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
end
