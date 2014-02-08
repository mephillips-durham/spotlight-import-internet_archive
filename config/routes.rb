Spotlight::Import::InternetArchive::Engine.routes.draw do

  resources :resources, only: [:new, :create]


end
