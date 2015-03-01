Rails.application.routes.draw do

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "usuarios#new", :as => "signup"

  get "event/newevent" => "eventos#new"
  post "event/createevent" => "eventos#create"
  post "event/accept" => "eventos#activate"
  post "event/delete" => "eventos#delete"
  get "event/edit/:id" => "eventos#edit"
  post "event/update" => "eventos#update"
  get "event/viewnotaceptedevents" => "eventos#viewnotaceptedevents"
  get "event/:id" => "eventos#view"

  post "usuarios/crearusu" => "usuarios#create"
  get "usuarios/controlusers" => "usuarios#controlusers"
  post "usuarios/delete" => "usuarios#delete"
  get "usuarios/edit/:id" => "usuarios#edit"
  get "usuarios/view/:id" => "usuarios#view"
  post "usuarios/update" => "usuarios#update"
  post "usuarios/activate" => "usuarios#activate"

  get "viewcalendario" => "calendario#viewcalendario"

  resources :users  
  resources :sessions  

  root :to => "start#index"

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
