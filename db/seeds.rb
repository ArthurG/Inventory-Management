# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(email: "adminuser@gmail.com",
						password: "password",
						password_confirmation: "password",
						user_type: "Owner")

99.times do |n|
	email = "usernum#{n}@fakeuser.org"
	type = (n % 6) + 1
	User.create(
		email: email, 
		user_type: type, 
		password: "password", 
		password_confirmation: "password")
end

ProductCategory.create!(name: "Wheel")