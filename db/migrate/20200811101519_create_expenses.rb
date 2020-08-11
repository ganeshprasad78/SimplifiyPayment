class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.references :group_member, foreign_key: true
      t.integer :amount
      t.integer :owe_to_group_member_id
      t.timestamps
    end
  end
end
