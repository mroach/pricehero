require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'setting the whodunnit user' do
    let(:user) { create(:user) }

    before do
      # Temporarily enable papertrail so this will be tested
      PaperTrail.enabled = true
      sign_in user
    end

    after do
      # And turn it back off just to be sure
      PaperTrail.enabled = false
    end

    it 'sets whodunit for PaperTrail' do
      get :show
      expect(response).to be_success # Ensure the sign-in worked
      expect(PaperTrail.whodunnit).to eq user.id
    end
  end
end
