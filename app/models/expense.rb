class Expense < ApplicationRecord
  belongs_to :group_member
  belongs_to :owe_to_group_member, class_name: 'GroupMember'

  validates :group_member_id, :amount, :owe_to_group_member_id, presence: true

  scope :by_group_members, ->(group_members) { where(group_member: group_members, owe_to_group_member: group_members) }
  scope :sum_of_amount, -> { select('sum(expenses.amount) as amount') }
  def data_hash
    member_hash.merge!(owe_hash).merge!(amount_hash)
  end

  def member_hash
    member = group_member.user
    expense = { member_id: member.id, member: member.full_name }
    expense.merge!(amount: amount)
  end

  def owe_hash
    owe_to = owe_to_group_member.user
    expense = { owe_to: owe_to.full_name, owe_to_id: owe_to.id }
    expense.merge!(amount: amount)
  end

  def amount_hash
    { amount: amount }
  end
end
