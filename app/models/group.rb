class Group < ApplicationRecord
  include DebtAction
  validates :name, presence: true

  has_many :group_members, dependent: :destroy
  has_many :users, through: :group_members

  def overall_debt_view
    expenses = collect_all_expenses

    { overall_view: (not_contributed_users(expenses) + collect_all_expenses) }
  end

  def simplified_debt_view
    spent = collect_spent_expenses
    owe = collect_owe_expenses

    deduct_same_member_owe_amount(owe, spent)
    deduct_same_member_spent_amount(collect_owe_expenses, spent)

    reject_if_zero_amount(spent)
    reject_if_zero_amount(owe)
    simplified_view = simplified_view(spent, owe)

    { simplified_view: simplified_view }
  end

  def simplified_view(spent, owe)
    view = []
    loop do
      sort_and_reverse(spent)
      sort_and_reverse(owe)

      spent_first = spent.first
      owe_first = owe.first
      owe_amount = smaller_amount(owe_first[:amount], spent_first[:amount])

      current_hash = simplified_hash(owe_amount, owe_first, spent_first)
      view.push(current_hash)

      # deduct credited amount
      deduct_spent_amount(spent, owe_amount, current_hash[:member_id])
      deduct_owe_amount(owe, owe_amount, current_hash[:owe_to_id])

      reject_if_zero_amount(spent)
      reject_if_zero_amount(owe)
      break if spent.blank?
    end
    view
  end

  def collect_all_expenses
    Expense
      .select(:group_member_id, :owe_to_group_member_id)
      .sum_of_amount
      .by_group_members(group_members)
      .group(:group_member_id, :owe_to_group_member_id)
      .map(&:data_hash)
  end

  def collect_spent_expenses
    Expense
      .select(:group_member_id)
      .sum_of_amount
      .by_group_members(group_members)
      .group(:group_member_id)
      .map(&:member_hash)
  end

  def collect_owe_expenses
    Expense
      .select(:owe_to_group_member_id)
      .sum_of_amount
      .by_group_members(group_members)
      .group(:owe_to_group_member_id)
      .map(&:owe_hash)
  end

  def not_contributed_users(expenses)
    users
      .where.not(id: member_ids(expenses))
      .map(&:data_hash)
  end
end
