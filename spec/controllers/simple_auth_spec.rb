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
