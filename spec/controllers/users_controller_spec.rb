require 'spec_helper'

describe UsersController do
  #post :create
  describe 'POST create' do
    # let(:new_user) { Fabricate(:user) }
    it 'creates new user when valid info is provided' do
      # post :create, user['screen_name'] => new_user.screen_name, user['email'] => new_user.email, user['password'] => new_user.password
      post :create, user: {screen_name: "johnny", email: "jon@gmail.com", password: "pass"}
      # expect(response).to redirect_to home_path
      expect(User.count).to eq(1)
    end
    it 'does not create user without screen name' do
      post :create, user: {screen_name: "", email: "jon@gmail.com", password: "pass"}
      # expect(response).to redirect_to home_path
      expect(User.count).to eq(0)
    end
    it 'does not create user without email' do
      post :create, user: {screen_name: "hiho", email: "", password: "pass"}
      # expect(response).to redirect_to home_path
      expect(User.count).to eq(0)
    end
    it 'does not create user without password' do
      post :create, user: {screen_name: "johnny5", email: "jon@gmail.com", password: ""}
      # expect(response).to redirect_to home_path
      expect(User.count).to eq(0)
    end
  end

end