require 'rails_helper'

RSpec.describe SimpleAuthentication::Interactors::DeleteUser do
	let(:user_klass_name) { 'user' }
	let(:user_klass) { User }
	let!(:user_to_delete) { create :user }
	let(:user_id) { user_to_delete.id }

	let(:call_interactor) do
		described_class.with(user_klass_name:, user_id:)
	end

	context 'with correct params' do
		it 'changes the number of users' do
			expect { call_interactor }.to change(user_klass, :count).by(-1)
		end

		it 'deletes the user with the specified id' do
			call_interactor
			expect { user_klass.find user_id }.to raise_error ActiveRecord::RecordNotFound
		end
	end

	context 'when the id belongs to a non-existing user' do
		let(:user_id) { (user_klass.last&.id || 0) + 1 }

		include_examples 'raises Error exception', ActiveRecord::RecordNotFound
	end
end
