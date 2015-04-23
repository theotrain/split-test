require 'spec_helper'

describe User do
 
  it { should have_many(:groups) }

  describe '#next_id_to_vote_on' do

    let(:current_user) { Fabricate(:user) }
    # before { session[:user_id] = current_user.id }

    it "gets a group when one available" do
      group = Fabricate(:group,
                        user: current_user,
                        items: [Fabricate(:item, group: group), Fabricate(:item, group: group)])
      user2 = Fabricate(:user)
      group2 = Group.new(user: user2, name: Faker::Lorem.word)
      group2.save(validate: false)
      item3 = Fabricate(:item, group: group2)
      item4 = Fabricate(:item, group: group2)

      vote = Fabricate(:vote, item: item3, user: current_user)

      group_no_votes = Group.new(user: user2, name: Faker::Lorem.word)
      group_no_votes.save(validate: false)
      item5 = Fabricate(:item, group: group_no_votes)
      item6 = Fabricate(:item, group: group_no_votes)

      current_user.next_id_to_vote_on.should eq(group_no_votes.id)
    end
    it "returns zero when there are only groups by current user" do
      group = Group.new(user: current_user, name: Faker::Lorem.word)
      group.save(validate: false)
      item1 = Fabricate(:item, group: group)
      item2 = Fabricate(:item, group: group)

      group2 = Group.new(user: current_user, name: Faker::Lorem.word)
      group2.save(validate: false)
      item3 = Fabricate(:item, group: group2)
      item4 = Fabricate(:item, group: group2)
      current_user.next_id_to_vote_on.should eq(0)
    end
    it "returns zero when there are no groups" do
      current_user.next_id_to_vote_on.should eq(0)
    end

  end

  describe '#voted_on?' do

    let(:current_user) { Fabricate(:user) }
    # before { session[:user_id] = current_user.id }

    it "returns true when user has voted on this group" do
      group = Group.new(user: current_user, name: Faker::Lorem.word)
      group.save(validate: false)
      item1 = Fabricate(:item, group: group)
      item2 = Fabricate(:item, group: group)
      item3 = Fabricate(:item, group: group)
      vote = Fabricate(:vote, item: item2, user: current_user)
      current_user.voted_on?(group).should eq(true)
    end
    it "returns false when user has not voted on this group" do
      group = Group.new(user: current_user, name: Faker::Lorem.word)
      group.save(validate: false)
      item1 = Fabricate(:item, group: group)
      item2 = Fabricate(:item, group: group)
      item3 = Fabricate(:item, group: group)
      current_user.voted_on?(group).should eq(false)
    end
  end


end