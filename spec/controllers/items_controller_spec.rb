require 'spec_helper'

describe ItemsController do
  describe 'GET vote' do 
    context 'not logged in' do
      it 'redirects to root path' do
        get :vote
        expect(response).to redirect_to root_path
      end
    end
    context 'logged in' do
      let(:current_user) { Fabricate(:user) }
      before {
        session[:user_id] = current_user.id
        request.env["HTTP_REFERER"] = "where_i_came_from"
      }

      it 'creates a new vote' do
        cat = Fabricate(:category)
        group = Group.new(user: current_user, category: cat, name: Faker::Lorem.word)
        group.save(validate: false)
        item1 = Fabricate(:item, group: group)
        get :vote, id: item1.id
        expect(Vote.count).to eq(1)
        expect(Vote.first.user).to eq(current_user)
      end

    end
  end


end
