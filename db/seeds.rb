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


ajay = User.create(first_name: 'Ajay', last_name: '')
arun = User.create(first_name: 'Arun', last_name: '')
charl = User.create(first_name: 'Charl', last_name: '')
dav = User.create(first_name: 'Dav', last_name: '')
franco = User.create(first_name: 'Franco', last_name: '')
jeev = User.create(first_name: 'Jeev', last_name: 'Dey')
ema = User.create(first_name: 'Ema', last_name: 'DFran')
dora = User.create(first_name: 'Dora', last_name: 'Lona')


group = Group.find_by(name: 'Seaview')

# Adding user to group
User.where(first_name: %w[Ajay Arun Charl Dav Franco Jeev Ema Dora]).find_each do |user|
  GroupMember.create(user_id: user.id, group_id: group.id)
end

#Expenses of each group member
ajay_gm = GroupMember.find_by(user_id: ajay.id, group_id: group.id)
arun_gm = GroupMember.find_by(user_id: arun.id, group_id: group.id)
charl_gm = GroupMember.find_by(user_id: charl.id, group_id: group.id)
dav_gm = GroupMember.find_by(user_id: dav.id, group_id: group.id)
franco_gm = GroupMember.find_by(user_id: franco.id, group_id: group.id)
jeev_gm = GroupMember.find_by(user_id: jeev.id, group_id: group.id)
ema_gm = GroupMember.find_by(user_id: ema.id, group_id: group.id)
dora_gm = GroupMember.find_by(user_id: dora.id, group_id: group.id)


Expense.create(group_member_id: arun_gm.id, owe_to_group_member_id: charl_gm.id, amount: 40)
Expense.create(group_member_id: arun_gm.id, owe_to_group_member_id: ema_gm.id, amount: 80)

Expense.create(group_member_id: charl_gm.id, owe_to_group_member_id: ajay_gm.id, amount: 80)
Expense.create(group_member_id: ema_gm.id, owe_to_group_member_id: dav_gm.id, amount: 120)

Expense.create(group_member_id: jeev_gm.id, owe_to_group_member_id: franco_gm.id, amount: 300)
Expense.create(group_member_id: jeev_gm.id, owe_to_group_member_id: dav_gm.id, amount: 80)
Expense.create(group_member_id: franco_gm.id, owe_to_group_member_id: arun_gm.id, amount: 145)
Expense.create(group_member_id: ema_gm.id, owe_to_group_member_id: ajay_gm.id, amount: 145)
