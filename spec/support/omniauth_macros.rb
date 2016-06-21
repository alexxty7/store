module OmniauthMacros
  def mock_auth_hash(email = 'new@user.com')
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      provider: 'facebook',
      uid: '1235456',
      info: { email: email }
    )
  end
end
