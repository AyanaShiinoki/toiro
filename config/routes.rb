Rails.application.routes.draw do

# user #
# ---------------------------------------------------

# devise
  devise_for :users, controllers: {
    sessions:      'devise/users/sessions',
    passwords:     'devise/users/passwords',
    registrations: 'devise/users/registrations'
  }

# 機能
  root 'users/home#top'
  get "home/about" => "users/home#about"
  get "random/:id" => "users/exhibitions#random" , as: "random"
namespace :users do
  resources :notifications, only: :index
  resources :users, only: [:show, :index, :edit, :update, :destroy] do
    resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follower', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
  end
  resources :galleries, except: [:destroy]
  resources :exhibitions do
    resource :comments, only: [:new, :create, :destroy]
    resource :likes, only: [:create, :destroy]
    resource :clips, only: [:create, :destroy]
  end
  resources :works
  resources :folders, except: [:new]
  end












# ---------------------------------------------------

# admin #

# devise
  devise_for :admins, controllers: {
    sessions:      'devise/admins/sessions',
    passwords:     'devise/admins/passwords',
   registrations: 'devise/admins/registrations'
  }


# 機能
  namespace :admins do
    root 'home#top'
    resources :users, only: [:show, :index, :edit, :update]
    resources :galleries, except: [:destroy]
    resources :exhibitions do
      resource :comments, only: [:destroy]
    end
    resources :works
  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
