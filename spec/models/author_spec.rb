require 'rails_helper'

RSpec.describe Author do
  context 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  context 'associations' do
    it { is_expected.to have_many(:books) }
  end
end
