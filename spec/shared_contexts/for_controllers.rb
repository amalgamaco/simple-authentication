RSpec.shared_context 'when using doorkeeper' do
	let(:token) { instance_double 'doorkeeper_token' }
	let(:current_user) { create :user }

	before do
		allow(token).to receive(:acceptable?).and_return(true)
		allow(token).to receive(:resource_owner_id).and_return(current_user.id)
		allow(controller).to receive(:doorkeeper_token) { token }
	end
end
