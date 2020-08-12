module DebtAction
  extend ActiveSupport::Concern

  def simplified_hash(amount, owe_hash, spent_hash)
    { amount: amount,
      member_id: spent_hash[:member_id], member: spent_hash[:member],
      owe_to_id: owe_hash[:owe_to_id], owe_to: owe_hash[:owe_to] }
  end

  def member_ids(expenses)
    expenses.map { |e| [e[:member_id], e[:owe_to_id]] }.flatten
  end

  def smaller_amount(owe_amount, spent_amount)
    return spent_amount if owe_amount >= spent_amount

    owe_amount
  end

  def deduct_spent_amount(spent, amount, member_id)
    spent.map! do |s|
      s[:amount] -= amount if s[:member_id] == member_id
      s
    end
  end

  def deduct_owe_amount(owe, _owe_amount, member_id)
    owe.map! do |s|
      s[:amount] -= amount if s[:member_id] == member_id
      s
    end
  end

  def reject_if_zero_amount(expenses)
    expenses.reject! { |o| o[:amount].zero? }
  end

  def sort_and_reverse(expenses)
    expenses.sort_by! { |k| k[:amount] }.reverse!
  end

  def deduct_same_member_owe_amount(owe, spent)
    owe.each do |o|
      current_member_spent = 0

      spent.each do |s|
        current_member_spent = s[:amount] if s[:member_id] == o[:owe_to_id]
      end
      o[:amount] = [(o[:amount] - current_member_spent), 0].max
    end
    owe
  end

  def deduct_same_member_spent_amount(owe, spent)
    spent.each do |o|
      current_member_owe = 0
      owe.each do |s|
        current_member_owe = s[:amount] if s[:owe_to_id] == o[:member_id]
      end
      o[:amount] = [(o[:amount] - current_member_owe), 0].max
    end
    spent
  end
end
