Shop::Application.routes.draw do

  resources :photos


  get "apple/index"

  get "welcome/index"

  get "admin/index"
  get "admin/test"

  get "staffs/update1"
  post "staffs/update2"

  get "sessions/new"

  post "sessions/create"

  get "sessions/destroy"

  get'sessions/new_user'
  post'sessions/create_user'
  get'sessions/destroy_user'
  get "applications/see_staff"

  #devise_for :users

  get "home/index"
  #get "products/pre_add_product"
  #post "products/add_product"


  root :to => "welcome#index"

  controller :chart do
    get "chart/staff_chart"=>:pre_staff_chart
    post "chart/staff_chart"=>:staff_chart

  end

  controller :products do
    get 'products/add_product' => :pre_add_product
    post 'products/add_product' => :add_product
    get 'products/query' => :pre_query
    post 'products/query' => :query 
    get'products/pre_check'=> :pre_check 
    post'products/after_check'=>:after_check
    get 'products/low_stack'=>:low_stack
    post 'products/after_purchase'=>:after_purchase

  end

  controller :users do
    post 'users/query_by_number'=>:query_by_number
    get'users/update_password'=>:pre_update_password
    post'users/update_password'=>:update_password
  end

  controller :sells do
    post 'sells/check_sell'=>:check_sell
    get'sells/sell_user'=>:sell_user_index
    get'sells/total_staff_sell'=>:total_staff_sell
    get'sells/total_staff_all_sell'=>:total_staff_all_sell
  end

  controller :say do
    post "say/search"=>:search_product
  end
  resources :say do
    get :find_p_by_brand, :on=>:member
    get :find_p_by_category, :on=>:member
    get :show_product, :on=>:member
  end


  controller :acounts do
    get 'acounts/user_app_find_password' => :pre_user_app_find_password
    post 'acounts/user_app_find_password'=> :user_app_find_password
    post 'acounts/user_modify_password'=>:user_modify_password
    get 'acounts/staff_app_find_password' => :pre_staff_app_find_password
    post 'acounts/staff_app_find_password'=> :staff_app_find_password
    post 'acounts/staff_modify_password'=>:staff_modify_password
  end

  resources :acounts do
    get :pre_user_modify_password, on: :member
    get :pre_staff_modify_password, on: :member
  end

 

  controller :repurchases do
    post 'repurchases/handle_resell'=>:handle_resell
  end

  controller :applications do
    get "applications/index_user"=>:index_user
  end

 resources :applications do
  get :pre_create_app, :on=>:member
  get :handle_app,:on=>:member
 end


  resources :repurchases


  resources :sells


  resources :orders


  resources :members


  resources :products do
    #resources :images
    get :autocomplete_product_number, :on => :collection
    get :check, :on=> :member
    get :purchase, :on=> :member
    get :pre_add_sell,:on=>:member

  end

  controller :staffs do
     get 'staffs/update_password'=>:pre_update_password
     post 'staffs/update_password'=>:update_password
  end

  resources :staffs,:users do
    get "reset", :on => :member
  end
  resources :units

  resources :brands,:categories  do
    get 'delete', :on => :member
  end

 #match "/:controller/delete/:id"


  # The priority is based upon order of creation:
  # first created -> highest priority.

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
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
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
  #       get 'recent', :on => :collection
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
