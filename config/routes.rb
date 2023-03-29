Rails.application.routes.draw do

  namespace :admin do
    resources :order_details, only: [:update]

    resources :orders, only: [:show, :update]

    resources :customers, only: [:index, :show, :edit, :update]

    resources :genres, only: [:index, :create, :edit, :update]

    resources :items, only: [:index, :new, :create, :show, :edit, :update]

    get '/' => 'homes#top'

  end

  scope module: :public do

   resources :addresses, only: [:index, :edit, :create, :update, :destroy]

   resource :order, only: [:new, :create, :index] do
     collection do
      post :confirm
      get :cmplete
     end
    end

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

    resources :items, only: [:index, :show]

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
