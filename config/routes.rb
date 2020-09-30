Rails.application.routes.draw do
  root to: "interfaces#get_venue"
  get 'get_best_seat', to: "interfaces#get_best_seat"
end
