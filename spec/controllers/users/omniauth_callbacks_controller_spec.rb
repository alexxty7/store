require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController do
  let(:user) { create(:user) }

  describe '#facebook' do
    before do
      OmniAuth.config.test_mode = true
      request.env['devise.mapping'] = Devise.mappings[:user]
      request.env['omniauth.auth'] = mock_auth_hash
    end

    context 'user persisted' do
      before do    
        allow(User).to receive(:from_omniauth) { user }
        get :facebook
      end

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

    context 'with invalid params' do
      before do
        allow(User).to receive(:from_omniauth) { User.new }
        get :facebook
      end

      it "assigns session['devise.facebook_data']" do
        expect(session['devise.facebook_data']).not_to be_nil
      end

      it 'redirects to new_user_registration_url' do
        expect(response).to redirect_to(new_user_registration_url)
      end
    end
  end
end
