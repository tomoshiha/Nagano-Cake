Rails.application.routes.draw do

  namespace :admin do
    get 'orders_details/update'

    get 'orders/show'
    get 'orders/update'

    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
    get 'customers/update'

    get 'genres/index'
    get 'genres/create'
    get 'genres/edit'
    get 'genres/update'

    resources :items, only: [:show, :edit, :update]
    resource :item, only: [:index, :new, :create]

    get '/' => 'homes#top'
  end

  scope module: :public do

   resources :addresses, only: [:edit, :update, :destroy] do
    get '/addresses' => 'addresses#index'
    post '/addresses' => 'addresses#create'
   end

   resource :order, only: [:new, :create, :index] do
     collection do
      post :confirm
      get :cmplete
     end
    end
    resources :orders, only: [:show]

    resources :cart_items, only: [:index, :update, :destroy, :create] do
     collection do
       delete :destroy_all
     end
    end

    resource :customer, only: [:show, :edit, :update] do
     collection do
       get :unsubscribe
       patch :withdraw
     end
    end

    resources :items, only: [:show]
    get '/items' => 'items#index'

    root to: 'homes#top'
    get '/about' => 'homes#about'
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
