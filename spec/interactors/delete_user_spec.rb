require 'rails_helper'

RSpec.describe SimpleAuthentication::Interactors::DeleteUser do
	let(:user_klass_name) { 'user' }
	let(:user_klass) { User }
	let!(:user_to_delete) { create :user }
	let(:user_id) { user_to_delete.id }
	let(:delete_user_callback) { nil }

	let(:call_interactor) do
		described_class.with(user_klass_name:, user_id:, delete_user_callback:)
	end

	context 'with correct params' do
		it 'changes the number of users' do
			expect { call_interactor }.to change(user_klass, :count).by(-1)
		end

		it 'deletes the user with the specified id' do
			call_interactor
			expect { user_klass.find user_id }.to raise_error ActiveRecord::RecordNotFound
		end

		context 'when a delete_user_callback is given' do
			it 'calls the callback with the deleted user' do
				email_of_deleted_user = nil
				delete_user_callback = proc { |deleted_user| email_of_deleted_user = deleted_user.email }

				described_class.with( user_klass_name:, user_id:, delete_user_callback:)

				expect( email_of_deleted_user ).to eq user_to_delete.email
			end
		end
	end

	context 'when the id belongs to a non-existing user' do
		let(:user_id) { (user_klass.last&.id || 0) + 1 }

		include_examples 'raises Error exception', ActiveRecord::RecordNotFound
	end
end
