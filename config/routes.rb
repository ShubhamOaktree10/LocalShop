Rails.application.routes.draw do
  root "users#index"

  resources :users do
    resources :shops do
      resources :categories do
        resources :products do
          resources :quantities
        end
      end
    end
  end
  
  resources :admins,    only: [:index, :edit, :show]
  resources :sellers,   only: [:index]
  resources :buyers,    only: [:index]
  resources :carts,     only: [:index, :create, :destroy]
  resources :favorites, only: [:index, :create, :destroy] 
  resources :buys,      only: [:index, :create]
  resources :ratings,   only: [:create, :update]

  get 'allusers'      => 'admins#allusers'
  get 'allshops'      => 'admins#allshops'
  get 'allcategories' => 'admins#allcategories'
  get 'edituser'      => 'admins#edituser'
  get 'showproduct'   =>  'users#showproduct'
  get 'search'        =>  'users#search'
  get 'reusers'       =>  'users#reusers'
 
  
  post 'roles' => 'roles#create'
 
  get 'signup' => 'users#new'
  get '/login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
