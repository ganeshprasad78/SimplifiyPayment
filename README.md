SimplifyPayment

This is an api only rails application.
Objective of the app is to simplify total number of payments done within the group.
This application restructures payment within groups of people. It does not change the total amount that anyone owes, but it makes it easier to pay people back by minimizing the total number of payments.

ruby version - 2.6.2
rails version - 6.0.3

rails new SimplifyPayment my_api --api -d postgresql

Add gem 'dotenv-rails' to read from .env file. Ensure it is at the top after rails gem

touch .env

add .env to .gitignore



http://localhost:3000/groups.json
Running mini tests
rake test
rake test test/controllers/groups_controller_test.rb
rake test test/models/group_test.rb


overall payment view
http://localhost:3000/groups/:id/overall_debt_view.json
simplified payment view
http://localhost:3000/groups/:id/simplified_debt_view.json



Traceback (most recent call last):
        1: from (irb):1
NameError (uninitialized constant User)
irb(main):002:0> reload!
Reloading...
=> true
irb(main):003:0> User.first
  User Load (0.3ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1  [["LIMIT", 1]]

