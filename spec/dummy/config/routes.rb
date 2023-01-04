Rails.application.routes.draw do
	use_doorkeeper :scope => 'v1/oauth' do
		skip_controllers :authorizations, :applications, :authorized_applications
	end

	devise_for :users, skip: [:confirmations, :registrations, :unlocks]

	devise_scope :users do
		post 'users' => 'users#sign_up'
		delete 'users' => 'users#delete'
		post 'users/:blocked_user_id/block' => 'users#block'
		post 'users/:blocked_user_id/unblock' => 'users#unblock'

		post 'users/forgot_password' => 'users#forgot_password'
		post 'users/reset_password' => 'users#reset_password'
	end

	post 'empty' => 'empty#sign_up'
	post 'empty/forgot_password' => 'empty#forgot_password'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
