Calendar::Application.routes.draw do
  resources :workouts do  
    collection do  
      get :edit_multiple
      put :update_multiple
    end
  end
end
