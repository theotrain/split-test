require 'spec_helper'

describe ApplicationHelper do
  describe '#get_item_percent' do
    it 'calculates correct item percentage with 2 items' do
      group = Fabricate(:group, user_id: 1, category_id: 1)
      item1 = Fabricate(:item, group: group)
      item2 = Fabricate(:item, group: group)
      vote1 = Vote.create(vote: true, item: item1)
      vote2 = Vote.create(vote: true, item: item1)
      vote3 = Vote.create(vote: true, item: item2)
      helper.get_item_percent(item1).should eq(67)
    end
    it 'calculates correct item percentage with 3 items' do
      group = Fabricate(:group, user_id: 1, category_id: 1)
      item1 = Fabricate(:item, group: group)
      item2 = Fabricate(:item, group: group)
      item3 = Fabricate(:item, group: group)
      vote1 = Vote.create(vote: true, item: item1)
      vote2 = Vote.create(vote: true, item: item1)
      vote3 = Vote.create(vote: true, item: item2)
      vote4 = Vote.create(vote: true, item: item2)
      vote5 = Vote.create(vote: true, item: item3)
      helper.get_item_percent(item1).should eq(40)
    end
    it 'returns zero when vote count is zero' do
      group = Fabricate(:group, user_id: 1, category_id: 1)
      item1 = Fabricate(:item, group: group)
      item2 = Fabricate(:item, group: group)
      helper.get_item_percent(item1).should eq(0)
    end
  end

end