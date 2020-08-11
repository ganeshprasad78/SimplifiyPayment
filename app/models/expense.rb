class Expense < ApplicationRecord
  belongs_to :group_member
  belongs_to :owe_to_group_member, class_name: 'GroupMember'

  validates :group_member_id, :amount, :owe_to_group_member_id, presence: true
end
