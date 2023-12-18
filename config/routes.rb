Rails.application.routes.draw do
   devise_for :admins, controllers: {
     sessions: 'admin/sessions',
     registrations: 'admin/registrations' # カスタムコントローラーを指定
   }, registrations: false


   devise_for :customers, controllers: {
     sessions: 'customer/sessions',
     registrations: 'customer/registrations'
   }
   root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
