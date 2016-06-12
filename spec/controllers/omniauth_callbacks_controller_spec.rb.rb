require 'rails_helper'

RSpec.describe OmniauthCallbacksController do
  let(:user) { create(:user) }

  before do
    OmniAuth.config.test_mode = true
    mock_auth_hash
    request.env['devise.mapping'] = Devise.mappings[:user]
    allow(User).to receive(:from_omniauth) { user }
  end

  describe '#facebook' do
    before { get :facebook }

    it 'authenticate user' do
      expect(warden.authenticated?(:user)).to be_truthy
    end

    it 'set current_user' do
      expect(controller.current_user).not_to be_nil
    end

    it 'redirect to root_path' do
      expect(response).to redirect_to(root_path)
    end
  end
end
