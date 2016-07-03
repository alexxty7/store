require 'rails_helper'

RSpec.describe ReviewsController do
  let!(:book) { create(:book) }

  describe 'GET #new' do
    sign_in_user

    before { get :new, params: { book_id: book } }

    it 'assigns @review' do
      expect(assigns(:review)).to be_a_new(Review)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      it 'saves the new review in database' do 
        expect {
          post :create, params: { book_id: book, review: attributes_for(:review) }
        }.to change(Review, :count).by(1)
      end

      it 'redirect to book show path' do 
        post :create, params: { book_id: book, review: attributes_for(:review) }
        expect(response).to redirect_to(book_path(book))
      end
    end

    context "with invalid attributes" do
      it 'does not save the review' do
        expect {
          post :create, params: { book_id: book, review: attributes_for(:invalid_review) }
        }.to_not change(Review, :count)
      end

      it 're-renders new view' do
        post :create, params: { book_id: book, review: attributes_for(:invalid_review) }
        expect(response).to render_template :new
      end
    end
  end
end