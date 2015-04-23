class User < ActiveRecord::Base
  has_many :groups
  has_many :votes
  has_secure_password
  validates_presence_of :screen_name, :email, :on => :create
  validates_uniqueness_of :email

  def next_id_to_vote_on
    exclude_my_groups = Group.where.not(user: self)
    return 0 if exclude_my_groups.empty?
    exclude_voted_on = exclude_my_groups.reject{|g| self.voted_on?(g)}
    return 0 if exclude_voted_on.empty?
    exclude_voted_on.sample.id
  end

  def voted_on?(group)
    group.items.any?{|item| !item.votes.where(user: self).empty?}
  end
end