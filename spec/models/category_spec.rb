require 'rails_helper'

RSpec.describe Category do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end

  context 'associations' do
    it { is_expected.to have_many(:books) }
  end
end
