Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  defaults format: :json do
    post('/drivers/new', to: 'drivers#create')
    get('/driver/:driver_id/rides', to: 'rides#show_rides')
    post('/ride/new', to: 'rides#create_ride')
    post('/ride/:ride_id/accept-ride', to: 'rides#accept_ride')
    post('/ride/:ride_id/update-status', to: 'rides#update_ride_status')
    get('/user/:user_id/rides', to: 'users#show_rides')
  end
end
