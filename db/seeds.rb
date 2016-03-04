# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'rubygems'
require 'faker'

def seed_klass(num)
  Klass.find_or_create_by(name: num.to_s)
  print "."
end

def seed_section(klass, name)
  # Section.find_or_create_by(klass_id: klass.id, name: name)
  klass.sections.find_or_create_by(name: name)
  print "."
end

def seed_house(name)
  House.find_or_create_by(name: name)
  print "."
end

def seed_student(section, house, roll_no)
  last_name = Faker::Name.last_name
  age = section.klass.name.to_i + 5
  section.students.find_or_create_by(roll_number: roll_no) do |student|
    student.house = house
    student.name = "#{Faker::Name.first_name} #{last_name}"
    student.fathers_name = "#{Faker::Name.first_name} #{last_name}"
    student.gender = Student::Gender.all.sample
    student.email = Faker::Internet.email
    student.dob = Faker::Date.between((age + 1).years.ago, (age - 1).years.ago)
    student.phone = Faker::PhoneNumber.cell_phone
    student.address = "#{Faker::Address.street_address}, #{Faker::Address.city} - #{Faker::Address.zip}"
  end
  print "."
end

puts "# Seeding Klasses"
(1..10).each do |num|
  seed_klass(num)
end
puts "  Done."

puts "# Seeding Sections"
Klass.all.each do |klass|
  sections = %w[A B C]
  (0..(1 + rand(2))).each do |i|
    name = sections[i]
    seed_section(klass, name)
  end
end
puts "  Done."

puts "# Seeding Houses"
%w[Yellow Red Blue Green].each do |name|
  seed_house(name)
end
puts "  Done."

puts "# Seeding Students"
Section.all.each do |section|
  all_houses = House.all
  (1..(20+rand(6))).each do |roll_no|
    house = all_houses.sample
    seed_student(section, house, roll_no)
  end
end
puts "  Done."
