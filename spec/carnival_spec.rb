require './lib/carnival'
require './lib/attendee'
require './lib/ride'

RSpec.describe Carnival do

  describe 'initialize' do
    it 'exists' do
      jeffco_fair = Carnival.new('Jefferson County Fair')

      expect(jeffco_fair).to be_an_instance_of(Carnival)
    end

    it 'has a name' do
      jeffco_fair = Carnival.new('Jefferson County Fair')

      expect(jeffco_fair.name).to eq('Jefferson County Fair')
    end

    it 'has no rides by default' do
      jeffco_fair = Carnival.new('Jefferson County Fair')

      expect(jeffco_fair.rides).to eq([])
    end

    it 'has no attendees by default' do
      jeffco_fair = Carnival.new('Jeffco County Fair')

      expect(jeffco_fair.attendees).to eq([])
    end
  end

  describe '#add_ride' do
    it 'can add a ride' do
      jeffco_fair = Carnival.new('Jefferson County Fair')
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})

      jeffco_fair.add_ride(bumper_cars)

      expect(jeffco_fair.rides).to eq([bumper_cars])
    end
  end

  describe '#recommend_rides' do
    it 'recommends rides based on interests' do
      jeffco_fair = Carnival.new('Jefferson County Fair')
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
      ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
      scrambler = Ride.new({name: 'Scrambler', cost: 15})
      bob = Attendee.new('Bob', 20)
      sally = Attendee.new('Sally', 20)

      jeffco_fair.add_ride(bumper_cars)
      jeffco_fair.add_ride(ferris_wheel)
      jeffco_fair.add_ride(scrambler)
      bob.add_interest('Ferris Wheel')
      bob.add_interest('Bumper Cars')

      expect(jeffco_fair.recommend_rides(bob)).to eq([ferris_wheel, bumper_cars])
    end
  end

  describe '#admit' do
    it 'can track attendees' do
      jeffco_fair = Carnival.new('Jefferson County Fair')
      bob = Attendee.new('Bob', 0)
      sally = Attendee.new('Sally', 20)
      lando = Attendee.new('Lando', 5)
      luke = Attendee.new('Luke', 10)

      jeffco_fair.admit(bob)
      jeffco_fair.admit(sally)
      jeffco_fair.admit(lando)
      jeffco_fair.admit(luke)

      expect(jeffco_fair.attendees).to eq([bob, sally, lando, luke])
    end
  end
end
