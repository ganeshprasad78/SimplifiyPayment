class Group < ApplicationRecord
  validates :name, presence: true

  has_many :group_members, dependent: :destroy
  has_many :users, through: :group_members

  def overall_debt_view
    expenses = collect_all_expenses

    (not_contributed_users(expenses) + expenses)
  end

  def collect_all_expenses
    Expense
      .select(:group_member_id, :owe_to_group_member_id)
      .select('sum(expenses.amount) as amount')
      .by_group_members(group_members)
      .group(:group_member_id, :owe_to_group_member_id)
      .map(&:data_hash)
  end

  def not_contributed_users(expenses)
    users
      .where.not(id: member_ids(expenses))
      .map(&:data_hash)
  end

  def member_ids(expenses)
    expenses.map { |e| [e[:member_id], e[:owe_to_id]] }.flatten
  end

  def simplified_debt_view
  end
end
