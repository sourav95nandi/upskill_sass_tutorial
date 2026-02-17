Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  resources :contacts, except: [:new]
  get 'contact', to: 'contacts#new', as: 'new_contact'
end
