# There are two ways to populate the database:
# - `db:seed` (or `db:setup`) will load the seed data here and is for production purpose
# - `db:fixtures:load` will load all test fixutres and is only for development and test
#
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Create an initial administrator
initial_admin = User.create(
  mobile: '18812345678',
  password: 'Pa55word',
  password_confirmation: 'Pa55word'
)

# Create all hard-coded roles
%w[_admin_ _staff_ user].each do |role|
  initial_admin.roles << Role.create(name: role)
end

# Create one client at least
Client.create(codename: 'mefit-web')
