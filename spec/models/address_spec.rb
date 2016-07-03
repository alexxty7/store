require 'rails_helper'

RSpec.describe Address do
  context 'validations' do
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:zipcode) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_presence_of(:country) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:country) }
  end
end
