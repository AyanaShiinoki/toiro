Rails.application.routes.draw do

# userのdevise
  devise_for :users, controllers: {
    sessions:      'devise/users/sessions',
    passwords:     'devise/users/passwords',
    registrations: 'devise/users/registrations'
  }


  devise_for :admins, controllers: {
    sessions:      'devise/admins/sessions',
    passwords:     'devise/admins/passwords',
   registrations: 'devise/admins/registrations'
  }




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
