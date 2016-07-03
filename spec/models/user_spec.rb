require 'rails_helper'

RSpec.describe User do
  context 'associations' do
    it { is_expected.to have_many(:orders) }
    it { is_expected.to belong_to(:billing_address) }
    it { is_expected.to belong_to(:shipping_address) }
  end

  describe '#billing_address' do
    it 'returns new address if user.billing_address is nil' do
      expect(subject.billing_address).to be_a(Address)
    end

    it 'returns user.billing_address if user has one' do
      address = create(:address)
      user = create(:user, billing_address: address)
      expect(user.billing_address).to eq(address)
    end
  end

  describe '#shipping_address' do
    it 'returns new address if user.shipping_address is nil' do
      expect(subject.shipping_address).to be_a(Address)
    end

    it 'returns user.shipping_address if user has one' do
      address = create(:address)
      user = create(:user, shipping_address: address)
      expect(user.shipping_address).to eq(address)
    end
  end

  describe '.from_omniauth' do
    let(:auth) do
      OmniAuth::AuthHash.new(
        provider: 'facebook',
        uid: '123456',
        info: { email: 'new@user.com' }
      )
    end

    context 'user already has provider and uid' do
      it 'returns the user' do
        user_with_auth = create(:user, provider: 'facebook', uid: '123456')
        expect(User.from_omniauth(auth)).to eq(user_with_auth)
      end
    end

    context 'user has not provider and uid' do
      let!(:user) { create(:user) }

        context 'user does not exist' do
        it 'creates new user' do
          expect { User.from_omniauth(auth) }.to change(User, :count).by(1)
        end

        it 'returns new user' do
          expect(User.from_omniauth(auth)).to be_a(User)
        end

        it 'fills user email' do
          user = User.from_omniauth(auth)
          expect(user.email).to eq(auth.info[:email])
        end

        it 'fills provider and uid' do
          user = User.from_omniauth(auth)

          expect(user.provider).to eq(auth.provider)
          expect(user.uid).to eq(auth.uid)
        end
      end
    end
  end

  describe '.new_with_session' do
    it 'assigns data from session' do
      session = {
        'devise.facebook_data' => {
          'provider' => 'facebook',
          'uid' => '1235456',
          'info' => { 'name' => 'alex' }
        }
      }
      user = User.new_with_session({}, session)

      expect(user).to be_a(User)
      expect(user.provider).to eq('facebook')
      expect(user.uid).to eq('1235456') 
      expect(user.username).to eq('alex')       
    end
  end
end
