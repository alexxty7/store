class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  has_many :orders
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'

  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :shipping_address

  def billing_address
    super || Address.new
  end

  def shipping_address
    super || Address.new
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.username = auth.info.name
    end
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

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"]
        user.provider = data['provider']
        user.uid = data['uid']
        user.username = data['info']['name']
      end
    end
  end
end
