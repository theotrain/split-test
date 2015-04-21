module ApplicationHelper
  def get_item_percent(item)
    group = item.group
    item_vote_count = Vote.where(item: item).count
    return 0 if item_vote_count == 0
    total_votes = vote_count(group)
    ((item_vote_count.to_f / total_votes) * 100).round
  end
  def vote_count(group)
    items_in_group = group.items
    total_votes = items_in_group.reduce(0) do |votes, this_item|
      votes + this_item.votes.count
    end
  end
end
