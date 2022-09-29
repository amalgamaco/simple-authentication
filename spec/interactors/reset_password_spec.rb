require 'spec_helper'
require 'rails_helper'

RSpec.shared_context 'stub reset_password_by_token for user class' do
	before do
		allow(user_klass_instance.class)
				.to receive(:reset_password_by_token)
				.and_return(user_klass_instance)
	end
end

RSpec.shared_context 'stub errors for user instance' do
	before do
		user_klass_instance.errors.add(:invalid_param)
	end
end
RSpec.describe SimpleAuthentication::Interactors::ResetPassword do
	let(:user_klass_instance) { create :user }
	let(:user_klass_name) { 'user' }
	let(:reset_password_params) do
		{
			password: new_password,
			password_confirmation:,
			reset_password_token:
		}
	end
	let(:new_password) { '12345678' }
	let(:password_confirmation) { new_password }
	let(:reset_password_token) { SecureRandom.alphanumeric(20).upcase }

	let(:call_interactor) do
		described_class.with(user_klass_name:, reset_password_params:)
	end

	include_context 'stub reset_password_by_token for user class'

	context 'with correct params' do
		it 'calls the reset_password_by_token moethod of the user class' do
			call_interactor
			expect(user_klass_instance.class)
					.to have_received(:reset_password_by_token)
					.with(reset_password_params)
		end
	end

	context 'with incorrect params' do
		include_context 'stub errors for user instance'

		context 'when the password is invalid' do
			let(:password) { 'invalid' }

			it 'returns an UnprocessableError' do
				expect { call_interactor }.to raise_error SimpleAuthentication::Errors::UnprocessableError
			end
		end

		context 'when the password confirmation mismatches' do
			let(:password_confirmation) { 'i_mismatch' }

			it 'returns an UnprocessableError' do
				expect { call_interactor }.to raise_error SimpleAuthentication::Errors::UnprocessableError
			end
		end

		context 'when the token is invalid' do
			let(:token) { 'invalidtokenorsmthiguess' }

			it 'returns an UnprocessableError' do
				expect { call_interactor }.to raise_error SimpleAuthentication::Errors::UnprocessableError
			end
		end

		context 'when the given klass name is invalid' do
			let(:user_klass_name) { 'cat' }

			it 'returns an error i guess' do
				expect { call_interactor }.to raise_error NameError
			end
		end
	end
end
