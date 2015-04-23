require 'spec_helper'

describe GroupsController do
  describe 'POST create' do 
    context 'not logged in' do
      it 'redirects to root path' do
        post :create
        expect(response).to redirect_to root_path
      end
    end
    context 'logged in' do

      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }

      it 'creates a new group and 3 new text items' do
        post :create,
          "group"=>{"name"=>"SOME GROUP NAME",
                    "items_attributes"=>{
                    "0"=>{"text"=>"First text area contents"},
                    "1"=>{"text"=>"Second text area contents"},
                    "2"=>{"text"=>"Third text area contents"}}}
        expect(Item.count).to eq(3)

      end
      it 'creates a new group and 2 new text items' do
        post :create,
          "group"=>{"name"=>"SOME GROUP NAME",
                    "items_attributes"=>{
                    "0"=>{"text"=>"First text area contents"},
                    "1"=>{"text"=>"Second text area contents"},
                    "2"=>{"text"=>""}}}
        expect(Item.count).to eq(2)
      end
      it 'redirects to statistics_path' do
        post :create,
          "group"=>{"name"=>"SOME GROUP NAME",
                    "items_attributes"=>{
                    "0"=>{"text"=>"First text area contents"},
                    "1"=>{"text"=>"Second text area contents"},
                    "2"=>{"text"=>"Third text area contents"}}}
        expect(response).to redirect_to statistics_path
      end

    end
  end


end
