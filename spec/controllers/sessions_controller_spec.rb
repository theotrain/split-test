require 'spec_helper'

describe SessionsController do
  describe 'POST create' do

    let(:existing_user) { Fabricate(:user) }

    it 'allows log in with valid email and pass' do
      post :create, email: existing_user.email, password: existing_user.password 
      expect(response).to redirect_to home_path
    end

    it 'sends us back to sign_in with invalid email or password' do
      post :create, email: 'joe@nonsense@com', password: 'yomoms'
      expect(response).to redirect_to sign_in_path
    end
  end
end