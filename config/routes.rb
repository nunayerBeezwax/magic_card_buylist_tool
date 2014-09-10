Poker::Application.routes.draw do
 root to: 'home#index'
  resources :questions  
end
