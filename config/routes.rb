ArtyGeekParty::Application.routes.draw do
  root to: "home#index"

  devise_for :users,  controllers: {sessions: 'sessions'}

  namespace :api, defaults: {format: 'json'}  do
    get '/users/next_birthday' => "users#next_birthday"
    get '/users/current_user' => "users#check_user"
    get '/parties/next_party' => "parties#next_party"
    resources :users, only: [:index]
    resources :parties
  end
end
