# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Chatroom.create(title: 'Public Lobby', peeps_count: 0)

User.create(name: 'BobBot', is_bot: true)
User.create(name: 'Ed', is_bot: false)
User.create(name: 'John', is_bot: false)
User.create(name: 'Nico', is_bot: false)