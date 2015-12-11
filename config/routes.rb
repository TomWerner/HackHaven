Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  resources :announcements
  resources :registration
  #root 'home#index'
  get 'registration/new/:id' => 'registration#new'

  resources :users do
    get 'confirm/:code' => 'users#confirm'
  end
  resources :contests
  match '/login', to: 'sessions#new', via: :get
  match '/login_create', to: 'sessions#create', via: :post  
  match '/logout', to: 'sessions#destroy', via: :delete

  resources :questions do
    resources :testcases
    post '/submit' => 'questions#submit'
    post '/submit_custom_testcase' => 'questions#submit_custom_testcase'
  end
  
  resources :teams
  get 'teams/remove/:id' => 'teams#remove'
  get 'teams/captainize/:id' => 'teams#captainize'
  get 'teams/leaderboard/:id' => 'teams#leaderboard'
  
  
  
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
  
  # This has to go at the end
  get '/', :controller => 'home', :action => :index
end
