require 'rails_helper'

RSpec.describe OrderItem do
  context 'validations' do
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:quantity) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:order) }
  end
end
