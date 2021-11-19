# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts 'Destroying...␥'
Fighter.destroy_all
Combat.destroy_all

IMG_URLS = [
  "https://avatarfiles.alphacoders.com/161/thumb-161319.jpg",
  "https://avatarfiles.alphacoders.com/161/thumb-161317.png",
  "https://avatarfiles.alphacoders.com/295/thumb-295957.jpg",
  "https://avatarfiles.alphacoders.com/266/thumb-266797.jpg",
  "https://avatarfiles.alphacoders.com/242/thumb-242408.jpg",
  "https://avatarfiles.alphacoders.com/224/thumb-224885.jpg",
  "https://avatarfiles.alphacoders.com/169/thumb-169080.jpg",
  "https://avatarfiles.alphacoders.com/913/thumb-91395.jpg",
  "https://avatarfiles.alphacoders.com/658/thumb-65874.jpg",
  "https://avatarfiles.alphacoders.com/913/thumb-91394.jpg"
]

10.times do |n|
  fighter = Fighter.new(name: Faker::Games::StreetFighter.unique.character)
  # byebug
  fighter.life_points = rand(30..50)
  fighter.attack_points = ((60 - fighter.life_points) / 5 ).round
  fighter.img_url = IMG_URLS[n]
  fighter.save
  puts "#{n} - #{fighter.name} is created!"
end

puts "add equipments"
Equipment.create!(name: "knif", attack: 1)
Equipment.create!(name: "sword", attack: 2)
Equipment.create!(name: "helmet", protect: 1)
Equipment.create!(name: "shield", protect: 1)

puts "done"
