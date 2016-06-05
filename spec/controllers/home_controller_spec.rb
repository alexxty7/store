require 'rails_helper'

RSpec.describe HomeController do
  describe 'GET #index' do
    let(:book) { create(:book) }

    before { get :index }

    it 'renders :index template' do
      expect(response).to render_template(:index)
    end

    it 'assigns @best_sellers' do
      expect(assigns(:best_sellers)).not_to be_nil
    end
  end
end
