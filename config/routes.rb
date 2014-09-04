Rails.application.routes.draw do

  get 'comments/create'

  get 'comments/new'

  devise_for :users

  root to: "articles#index"


  devise_scope :user do
    match "login", to: "devise/sessions#new", via: :get, as: :login
    match 'register', to: "devise/registrations#new", via: :get, as: :register
  end

  resources :articles do

    match "/tags/:tag_name", to: "tags#show", via: :get, as: :tag, on: :collection


    resources :comments, only: [:create, :edit, :update, :destroy]

    # match "/comments", to: "comments#create", via: :post, as: :comment, on: :member

    
    # match "/comments/:comment_id/edit", to: "comments#edit", via: :get, as: :edit_comment, on: :member
    # match "/comments/:comment_id", to: "comments#update", via: :patch, as: :update_comment, on: :member
    # match "/comments/:comment_id", to: "comments#destroy", via: :delete, as: :destroy_comment, on: :member
  end

  resources :categories



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
