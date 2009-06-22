ActionController::Routing::Routes.draw do |map|

  map.resources :questions do |question|
    question.resources :answers
  end

  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  map.connect '', :controller => "questions", :action => "ask"
  
  map.resources :users
  map.resource  :sessions, :controller => 'authentication'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login  '/login', :controller => 'authentication', :action => 'new'
  map.logout '/logout', :controller => 'authentication', :action => 'destroy'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
