require 'rails_helper'

RSpec.describe BooksController do
  let(:books) { create_list(:book, 2) }
  let(:book) { books.first }

  describe 'GET #index' do
    before { get :index }

    it 'populates an array of books' do
      expect(assigns(:books)).to match_array(books)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: book.id } }

    it 'assigns @book' do
      expect(assigns(:book)).to eq(book)
    end

    it 'renders :show template' do
      expect(response).to render_template(:show)
    end
  end
end
