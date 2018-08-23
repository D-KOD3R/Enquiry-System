Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :enquiries do 
  	member do
  		get 'view_enquiry'
  		put 'reply_enquiry'
  	end
  end

end
