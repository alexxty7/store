require 'rails_helper'

RSpec.describe CategoriesController do
  let(:category) { create(:category) }
  let(:book) { create(:book, category: category) }

  describe 'GET #show' do
    before { get :show, params: { id: category.id } }

    it 'populates an array of categories' do
      expect(assigns(:categories)).to match_array([category])
    end

    it 'assigns @category' do
      expect(assigns(:category)).to eq(category)
    end

    it 'assigns @books' do
      expect(assigns(:books)).to match_array([book])
    end

    it 'renders :show template' do
      expect(response).to render_template(:show)
    end
  end
end
