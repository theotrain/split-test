require 'spec_helper'

describe ApplicationController do
  describe '#next_group_id' do

    let(:current_user) { Fabricate(:user) }
    before { session[:user_id] = current_user.id }

    it "gets a group when one available" do
      group = Fabricate(:group, user: current_user)
      item1 = Fabricate(:item, group: group)
      item2 = Fabricate(:item, group: group)

      user2 = Fabricate(:user)
      group2 = Fabricate(:group, user: user2)
      item3 = Fabricate(:item, group: group2)
      item4 = Fabricate(:item, group: group2)
      vote = Fabricate(:vote, item: item3, user: current_user)

      group_no_votes = Fabricate(:group, user: user2)
      item5 = Fabricate(:item, group: group_no_votes)
      item6 = Fabricate(:item, group: group_no_votes)

      controller.next_group_id.should eq(group_no_votes.id)
    end
    it "returns zero when there are only groups by current user" do
      group = Fabricate(:group, user: current_user)
      item1 = Fabricate(:item, group: group)
      item2 = Fabricate(:item, group: group)

      group2 = Fabricate(:group, user: current_user)
      item3 = Fabricate(:item, group: group2)
      item4 = Fabricate(:item, group: group2)
      controller.next_group_id.should eq(0)
    end
    it "returns zero when there are no groups" do
      controller.next_group_id.should eq(0)
    end

  end

  describe '#user_vote_this_group' do

    let(:current_user) { Fabricate(:user) }
    before { session[:user_id] = current_user.id }

    it "returns true when user has voted on this group" do
      group = Fabricate(:group, user: current_user)
      item1 = Fabricate(:item, group: group)
      item2 = Fabricate(:item, group: group)
      item3 = Fabricate(:item, group: group)
      vote = Fabricate(:vote, item: item2, user: current_user)
      controller.user_vote_this_group?(group).should eq(true)
    end
    it "returns false when user has not voted on this group" do
      group = Fabricate(:group, user: current_user)
      item1 = Fabricate(:item, group: group)
      item2 = Fabricate(:item, group: group)
      item3 = Fabricate(:item, group: group)
      controller.user_vote_this_group?(group).should eq(false)
    end
  end



end 