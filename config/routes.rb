Rails.application.routes.draw do
  root "pages#home"
  get "/services", to: "pages#services"
  get "/about", to: "pages#about"
  get "/contact", to: "pages#contact"
  post "/contact", to: "pages#contact_submit"

  get "up" => "rails/health#show", as: :rails_health_check
end
