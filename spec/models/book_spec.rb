require 'rails_helper'

RSpec.describe Book do
  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:in_stock) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:author) }
    it { is_expected.to belong_to(:category) }
    # it { is_expected.to have_many(:ratings) }
    it { is_expected.to have_many(:order_items) }
  end

  describe '.best sellers' do
    let(:book) { create(:book_with_order, quantity: 2) }
    let(:book1) { create(:book_with_order) }

    it 'returns books ordered by order_items' do
      expect(Book.best_sellers).to eq([book, book1])
    end
  end
end
