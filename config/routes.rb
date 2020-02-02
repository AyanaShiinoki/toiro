Rails.application.routes.draw do

# user #

# devise
  devise_for :users, controllers: {
    sessions:      'devise/users/sessions',
    passwords:     'devise/users/passwords',
    registrations: 'devise/users/registrations'
  }

# 機能
  resources :users, only: [:show, :index, :edit, :update]
  resources :galleries, except: [:destroy]
  resources :exhibitions, except: [:destroy] do
    resource :comments, only: [:new, :create, :destroy]
    resource :likes, only: [:create, :destroy]
  end
  resources :works
  resources :folders











# user #

# ---------------------------------------------------

# admin #

# devise
  devise_for :admins, controllers: {
    sessions:      'devise/admins/sessions',
    passwords:     'devise/admins/passwords',
   registrations: 'devise/admins/registrations'
  }


# 機能
  namespace :admin do
    resources :users, only: [:show, :index, :edit, :update]
    resources :galleries, except: [:destroy]
    resources :exhibitions, except: [:destroy]
    resources :works
  end

# admin #

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
