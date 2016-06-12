require 'rails_helper'

RSpec.describe User do
  context 'associations' do
    it { is_expected.to have_many(:orders) }
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

      context 'user already exists' do
        let(:auth) do
          OmniAuth::AuthHash.new(
            provider: 'facebook',
            uid: '123456',
            info: { email: user.email }
          )
        end

        it 'does not create new user' do
          expect { User.from_omniauth(auth) }.to_not change(User, :count)
        end

        it 'add provider and uid to user' do
          user = User.from_omniauth(auth)

          expect(user.provider).to eq(auth.provider)
          expect(user.uid).to eq(auth.uid)
        end

        it 'returns the user' do
          expect(User.from_omniauth(auth)).to eq(user)
        end
      end

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
end
