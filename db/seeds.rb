# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Group.create(name: 'Adventure')
alice = User.create(first_name: 'Alice', last_name: '')
bob = User.create(first_name: 'Bob', last_name: '')
charlie = User.create(first_name: 'Charlie', last_name: '')
david = User.create(first_name: 'David', last_name: '')
fred = User.create(first_name: 'Fred', last_name: '')
group = Group.find_by(name: 'Adventure')
User.where(first_name: %w[Alice Bob Charlie David Fred]).find_each do |user|
  GroupMember.create(user_id: user.id, group_id: group.id)
end
alice_gm = GroupMember.find_by(user_id: alice.id, group_id: group.id)
bob_gm = GroupMember.find_by(user_id: bob.id, group_id: group.id)
charlie_gm = GroupMember.find_by(user_id: charlie.id, group_id: group.id)
david_gm = GroupMember.find_by(user_id: david.id, group_id: group.id)
fred_gm = GroupMember.find_by(user_id: fred.id, group_id: group.id)
Expense.create(group_member_id: bob_gm.id, owe_to_group_member_id: david_gm.id, amount: 35)
Expense.create(group_member_id: charlie_gm.id, owe_to_group_member_id: bob_gm.id, amount: 30)
Expense.create(group_member_id: charlie_gm.id, owe_to_group_member_id: david_gm.id, amount: 10)
Expense.create(group_member_id: david_gm.id, owe_to_group_member_id: fred_gm.id, amount: 45)
