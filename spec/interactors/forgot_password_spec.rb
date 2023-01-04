require 'spec_helper'
require 'rails_helper'

# rubocop:disable RSpec/AnyInstance
RSpec.shared_context 'when user_klass_instance sends an email' do
	before do
		allow_any_instance_of(user_klass_instance.class)
			.to receive(:send_reset_password_instructions)
			.and_return(user_klass_instance)
	end
end
# rubocop:enable RSpec/AnyInstance

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

			include_examples 'raises Error exception', ActiveRecord::RecordNotFound
		end

		context 'when it does not belong to an existing user' do
			let(:user_email) { 'johnDoe@fakeEmail123.com' }

			include_examples 'raises Error exception', ActiveRecord::RecordNotFound
		end
	end

	context 'when the given klass name is invalid' do
		let(:user_klass_name) { 'cat' }

		include_examples 'raises Error exception', NameError
	end
end
