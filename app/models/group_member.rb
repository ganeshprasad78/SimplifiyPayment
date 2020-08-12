class GroupMember < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :expenses, dependent: :destroy

  validates :group_id, presence: true
  validates :user_id, presence: true
end
