Rails.application.routes.draw do
  resources :shelters, :pets, :veterinary_offices, :veterinarians

  get '/', to: 'application#welcome'

  get '/applications/new', to: 'applications#new'
  get '/applications/:id', to: 'applications#show'
  post '/applications', to: 'applications#create'
  patch '/applications/:id', to: 'applications#update'

  get '/shelters/:shelter_id/pets', to: 'shelters#pets'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  post '/shelters/:shelter_id/pets', to: 'pets#create'

  get '/veterinary_offices/:veterinary_office_id/veterinarians', to: 'veterinary_offices#veterinarians'
  get '/veterinary_offices/:veterinary_office_id/veterinarians/new', to: 'veterinarians#new'
  post '/veterinary_offices/:veterinary_office_id/veterinarians', to: 'veterinarians#create'

  get 'admin/shelters', to: 'admin/shelters#index'
  get 'admin/shelters/:id', to: 'admin/shelters#show'

  get 'admin/applications/:id', to: 'admin/applications#show'
  patch 'admin/pet_applications/:id', to: 'admin/pet_applications#update'
end
