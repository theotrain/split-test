class Group < ActiveRecord::Base
  belongs_to :user
  has_many :items, :dependent => :destroy
  belongs_to :category

  accepts_nested_attributes_for :items,
  :allow_destroy => true,
  :reject_if     => :all_blank

  validates :name, :presence => true, :uniqueness => { case_sensitive: false }
end