require 'spec_helper'
require 'rails_helper'

RSpec.shared_context 'when user_klass_instance sends an email' do
	before do
		allow_any_instance_of(user_klass_instance.class)
				.to receive(:send_reset_password_instructions)
				.and_return(user_klass_instance)
	end
end

RSpec.describe SimpleAuthentication::Interactors::ForgotPassword do
	let(:user_klass_name) { 'user' }
	let(:user_klass_instance) { create :user }
	let(:user_email) { user_klass_instance.email }

	let(:call_interactor) do
		described_class.with(user_email:, user_klass_name:)
	end

	include_context 'when user_klass_instance sends an email'

	context 'with correct params' do
		it 'returns the user indicating the email was sent' do
			expect(call_interactor).to eq user_klass_instance
		end
	end

	context 'when the email is invalid' do
		context 'when it is empty' do
			let(:user_email) {}

			it 'returns an not found error' do
				expect{ call_interactor }.to raise_error ActiveRecord::RecordNotFound
			end
		end

		context 'when it does not belong to an existing user' do
			let(:user_email) { 'johnDoe@fakeEmail123.com' }

			it 'returns an not found error' do
				expect { call_interactor }.to raise_error ActiveRecord::RecordNotFound
			end
		end
	end

	context 'when the given klass name is invalid' do
		let(:user_klass_name) { 'cat' }

		it 'returns an error i guess' do
			expect { call_interactor }.to raise_error NameError
		end
	end
end
