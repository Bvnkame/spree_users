Spree::Core::Engine.routes.draw do
  get "/api/ingredients" => "home#ingredients"
  get "/tam" => "sessions#tam"
end
