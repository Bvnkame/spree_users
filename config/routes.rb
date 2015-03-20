Spree::Core::Engine.routes.draw do
  post "/api/login" => "log_user#login"
  post "/api/logout" => "log_user#logout"
end
