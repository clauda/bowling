Bowling::Application.routes.draw do
  
  match "dashboard", :to => "dashboard#index"
  match "about", :to => "dashboard#about"
  match "admin/post/:id", :to => "dashboard#post", :as => 'admin_post'

  root :to => "posts#index"

  devise_for :users do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
  end

  get 'users' => 'users#index'
  match 'profile' => 'profiles#show', :as => 'profile'
  match 'team' => 'profiles#index', :as => 'team'
  get 'profile/new' => 'profiles#new'
  post 'create' => 'profiles#create'
  get 'profile/edit' => 'profiles#edit'
  put 'update' => 'profiles#update'

  resources :posts do
    resources :comments
  end
  
  match 'publish/:id', :to => "posts#publish", :as => "publish"
  resources :categories
  match "category/:name", :to => "categories#posts_by_categories", :as => "filter"
  match "tag/:name", :to => "posts#tags", :as => "tag"
  get "rss" => "posts#rss"

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get :recent, :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  match ':slug/', :to => "posts#permalink", :as => "permalink"

end

