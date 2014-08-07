# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

QuestionType.destroy_all

QuestionType.create([{ type_name: 'Single Option'}, {type_name: 'Multi-Option'}, {type_name: 'Ranking'}, {type_name: 'Short Text'}, {type_name: 'Open-Ended Text'}])

User.destroy_all

User.create({email:'jose@intermediapost.com',password:'w3lcome'})