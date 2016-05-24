Rails.application.routes.draw do
  root 'savings_required_calculator#new'
  resource :savings_required_calculator, only: [:show, :new], controller: 'savings_required_calculator'
end
