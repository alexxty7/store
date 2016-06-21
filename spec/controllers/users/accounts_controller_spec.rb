require 'rails_helper'

RSpec.describe Users::AccountsController do
  sign_in_user

  describe 'GET #show' do
    before do
      create(:order, user: @user)
      get :show
    end

    [:orders_in_progress, 
      :orders_in_queue, 
      :orders_in_delivery, 
      :orders_delivered
    ].each do |variable|
      it "assigns @#{variable.to_s}" do
        expect(assigns(variable)).not_to be_nil
      end
    end

    it "renders :show template" do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #edit' do
    before { get :edit }

    it 'assigns @user' do
      expect(assigns(:user)).not_to be_nil
    end

    it 'render :edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user) }
    let(:user_params) { attributes_for(:user) }

    before do
      allow(controller).to receive(:current_user).and_return(user)
      allow(user).to receive(:update).and_return(true)
      patch :update, params: { user: user_params }
    end

    context 'with valid attributes' do
      it "assigns @user" do
        expect(assigns(:user)).not_to be_nil
      end
 
      it "receives update for @user" do
        expect(user).to have_received(:update)
      end
 
      it "sends success notice" do
        put :update, params: { user: user_params }
        expect(flash[:notice]).to eq 'Account was successfully updated.'
      end
 
      it "redirects to settings page" do
        put :update, params: { user: user_params }
        expect(response).to redirect_to edit_account_path
      end
    end

    context 'with invalid attributes' do
      before do
        allow(controller).to receive(:current_user).and_return(user)
        allow(user).to receive(:update).and_return(false)
        patch :update, params: { user: user_params }
      end

      it "renders :edit template" do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'PATCH #update_password' do
    let(:user) { create(:user) }
    let(:user_params) { attributes_for(:user) }

    before do
      allow(controller).to receive(:current_user).and_return(user)
      allow(user).to receive(:update_with_password).and_return(true)
      patch :update_password, params: { user: user_params }
    end

    context 'with valid attributes' do
      it "assigns @user" do
        expect(assigns(:user)).not_to be_nil
      end
 
      it "receives update for @user" do
        expect(user).to have_received(:update_with_password)
      end
 
      it "sends success notice" do
        expect(flash[:notice]).to eq 'Password was successfully updated.'
      end
 
      it "redirects to settings page" do
        expect(response).to redirect_to edit_account_path
      end
    end

    context 'with invalid attributes' do
      before do
        allow(controller).to receive(:current_user).and_return(user)
        allow(user).to receive(:update_with_password).and_return(false)
        patch :update_password, params: { user: user_params }      
      end

      it "renders :edit template" do
        expect(response).to render_template :edit
      end
    end
  end
end