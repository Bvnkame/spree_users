Spree::Core::Engine.routes.draw do
  post "/api/login" => "log_user#login"
  get "/api/logout" => "log_user#logout"
end
