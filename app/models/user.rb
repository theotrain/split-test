class User < ActiveRecord::Base
  has_many :groups
  has_many :votes
  has_secure_password
  validates_presence_of :screen_name, :email, :on => :create
  validates_uniqueness_of :email
end