# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Lecture.create(title: "Lecture1", description: "lalala", price: 0.0, duration: 1, date: Time.now, speaker_id: 1)
Lecture.create(title: "Lecture2", description: "lalala", price: 1.0, duration: 1, date: Time.now, speaker_id: 1)