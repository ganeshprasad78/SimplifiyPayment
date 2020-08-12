class Expense < ApplicationRecord
  belongs_to :group_member
  belongs_to :owe_to_group_member, class_name: 'GroupMember'

  validates :group_member_id, :amount, :owe_to_group_member_id, presence: true

  scope :by_group_members, ->(group_members) { where(group_member: group_members, owe_to_group_member: group_members) }

  def data_hash
    member = group_member.user
    owe_to = owe_to_group_member.user
    expense = { member_id: member.id, member: member.full_name }
    expense.merge!(owe_to: owe_to.full_name, owe_to_id: owe_to.id)
    expense.merge!(amount: amount)
  end
end
