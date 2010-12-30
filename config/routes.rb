SbicktRails::Application.routes.draw do
 resources :geotags do
    collection do
      get :list
    end
    
    resources :sbickerls
  end
end
