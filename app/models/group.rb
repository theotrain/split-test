class Group < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy
  validate :validate_item_quantity

  belongs_to :category

  accepts_nested_attributes_for :items,
                                allow_destroy: true,
                                reject_if: :all_blank

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def validate_item_quantity
    errors.add(:items, "insufficient.  You must fill in at least 2 boxes.") if items.size < 2
  end

end