Spree::Core::Engine.routes.draw do
  post "/api/login" => "log_user#login"
  post "/api/logout" => "log_user#logout"


	get "/api/user_account" => "api/users#user_account"
 	post "/api/change_password" => "api/users#change_password"
end
