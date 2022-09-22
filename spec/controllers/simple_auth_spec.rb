require 'rails_helper'
require 'rspec'

RSpec.shared_context 'with created klass_instance' do
	before do
		post :sign_up, params: user_attributes
	end
end

RSpec.describe SimpleAuthentication::Controllers::SimpleAuth, type: :controller do
	describe UsersController, type: :controller do
		describe 'POST create' do
			let(:user) { build :user }
			let(:user_attributes) { {} }

			context 'when the params are correct' do
				let(:user_attributes) { { email: user.email, password: 'password' } }

				include_context 'with created klass_instance'
				it 'responds with an ok code' do
					expect(response.status).to eq 204
				end
			end

			%i[email password].each do |param|
				context "with empty #{param}" do
					before { user_attributes[param] = '' }

					include_context 'with created klass_instance'
					it 'responds with an error' do
						expect(response.status).to eq 422
					end
				end
			end
		end

		describe 'POST reset_password' do
			let(:user) { create :user }
			let(:reset_password_params) do
				{
					password:,
					password_confirmation:,
					reset_password_token:
				}
			end

			let(:reset_password_token) { user.send_reset_password_instructions }
			let(:password) { 'n3wp455w0rd' }
			let(:password_confirmation) { password }


			context 'when the params are correct' do
				it 'responds with a no content status' do
					post :reset_password, params: reset_password_params
					expect(response.status).to eq 204
				end
			end

			%i[password password_confirmation reset_password_token].each do |param|
				context "with empty #{param}" do
					let(param) { '' }

					it 'responds with an error' do
						expect { post :reset_password, params: reset_password_params }.to raise_error ActionController::ParameterMissing
					end
				end
			end
		end
	end

	context 'when the subclass does not define either user_klass_name or user_attributes' do
		describe EmptyController, type: :controller do
			describe 'POST create' do
				it 'responds with an error' do
					expect { post :sign_up }.to raise_error RuntimeError
				end
			end
		end
	end
end
