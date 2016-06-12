class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  has_many :orders

  def self.from_omniauth(auth)
    user = find_by(provider: auth.provider, uid: auth.uid.to_s)
    return user if user

    email = auth.info[:email]
    user = find_by(email: email)
    if user
      user.update_attributes(provider: auth.provider, uid: auth.uid.to_s)
    else
      user = create(email: email, provider: auth.provider, uid: auth.uid.to_s)
    end
    user
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
