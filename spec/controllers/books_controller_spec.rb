require 'rails_helper'

RSpec.describe BooksController do
  describe 'GET #index' do
    let(:books) { create_list(:book, 2) }

    before { get :index }

    it 'populates an array of books' do
      expect(assigns(:books)).to match_array(books)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end
end
