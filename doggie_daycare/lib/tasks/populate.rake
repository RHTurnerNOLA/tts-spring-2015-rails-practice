namespace :db do

  desc "Clear the DB and fill with excellent sample data"
  task :populate => :environment do
    require 'populator'
    require 'faker'

#    DOG_NAMES  ....

# First, clear out the necessary tables
    # Clear out the data
    Owner.destroy_all
    Dog.destroy_all

    # Alternative way to clear all data
    [Owner, Dog].each do |o|
      o.destroy_all
    end

    # Even better way to clear all data
    [Owner, Dog].each(&:destroy_all)
# end of clearing tables

# Add owners
  Owner.populate 30 do |owner|
    owner.name = Faker::Name.name
    owner.phone = Faker::PhoneNumber.phone_number

    # add dogs
    Dog.populate 1..10 do |dog|
      dog.owner_id = owner.id
      dog.name = Faker::Hacker.abbreviation # having fun with dog names
      # dog.name = DOG_NAMES.sample
      dog.breed = Faker::App.name # having fun with breed names
      dog.age = rand(1..20)

    end # add dogs

  end # add owners

  end # task populate

end