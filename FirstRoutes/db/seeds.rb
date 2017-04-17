# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all

hank = User.create(name: 'Hank', email: 'propane@arlen.com')
peggy = User.create(name: 'Peggy', email: 'scrabble@arlen.com')
bobby = User.create(name: 'Bobby', email: 'magic@arlen.com')
