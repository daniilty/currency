Rails.application.routes.draw do
  get 'home/admin'
  root 'home#index'
  post 'new_forced', to: 'home#new_forced'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
