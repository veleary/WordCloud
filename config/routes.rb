WordCloud::Application.routes.draw do
  get 'tags/:tag', to: 'apps#index', as: :tag
  resources :apps   
end
