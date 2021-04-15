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

  describe '#attendees_by_ride_interest' do
    it 'returns a hash with attendees interested in certain rides' do
      jeffco_fair = Carnival.new('Jefferson County Fair')
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
      ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
      scrambler = Ride.new({name: 'Scrambler', cost: 15})
      bob = Attendee.new('Bob', 0)
      sally = Attendee.new('Sally', 20)
      lando = Attendee.new('Lando', 5)
      luke = Attendee.new('Luke', 10)

      jeffco_fair.add_ride(bumper_cars)
      jeffco_fair.add_ride(ferris_wheel)
      jeffco_fair.add_ride(scrambler)
      jeffco_fair.admit(bob)
      jeffco_fair.admit(sally)
      jeffco_fair.admit(lando)
      jeffco_fair.admit(luke)
      bob.add_interest('Ferris Wheel')
      bob.add_interest('Bumper Cars')
      sally.add_interest('Bumper Cars')
      lando.add_interest('Scrambler')
      luke.add_interest('Scrambler')

      expected = {
        bumper_cars => [bob, sally],
        ferris_wheel => [bob],
        scrambler => [lando, luke]
      }

      expect(jeffco_fair.attendees_by_ride_interest).to eq(expected)
    end
  end

  describe '#ticket_lottery_contestants' do
    it 'returns array of interestd attendees that do not have enough spending money' do
      jeffco_fair = Carnival.new('Jefferson County Fair')
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
      ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
      scrambler = Ride.new({name: 'Scrambler', cost: 15})
      bob = Attendee.new('Bob', 0)
      sally = Attendee.new('Sally', 20)
      lando = Attendee.new('Lando', 5)
      luke = Attendee.new('Luke', 10)

      jeffco_fair.add_ride(bumper_cars)
      jeffco_fair.add_ride(ferris_wheel)
      jeffco_fair.add_ride(scrambler)
      jeffco_fair.admit(bob)
      jeffco_fair.admit(sally)
      jeffco_fair.admit(lando)
      jeffco_fair.admit(luke)
      bob.add_interest('Ferris Wheel')
      bob.add_interest('Bumper Cars')
      sally.add_interest('Bumper Cars')
      lando.add_interest('Bumper Cars')
      luke.add_interest('Scrambler')

      expect(jeffco_fair.ticket_lottery_contestants(bumper_cars)).to eq([bob, lando])
    end
  end

  describe '#draw_lottery_winner' do
    it 'randomly draws a winner for lottery' do
      jeffco_fair = Carnival.new('Jefferson County Fair')
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
      ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
      scrambler = Ride.new({name: 'Scrambler', cost: 15})
      roller_coaster = Ride.new({name: 'Roller Coaster', cost: 77})
      bob = Attendee.new('Bob', 0)
      sally = Attendee.new('Sally', 20)
      lando = Attendee.new('Lando', 5)
      luke = Attendee.new('Luke', 10)

      jeffco_fair.add_ride(bumper_cars)
      jeffco_fair.add_ride(ferris_wheel)
      jeffco_fair.add_ride(scrambler)
      jeffco_fair.add_ride(roller_coaster)
      jeffco_fair.admit(bob)
      jeffco_fair.admit(sally)
      jeffco_fair.admit(lando)
      jeffco_fair.admit(luke)
      bob.add_interest('Ferris Wheel')
      bob.add_interest('Bumper Cars')
      sally.add_interest('Bumper Cars')
      lando.add_interest('Bumper Cars')
      luke.add_interest('Scrambler')

      expect(jeffco_fair.draw_lottery_winner(scrambler)).to eq('Luke')
      expect(jeffco_fair.draw_lottery_winner(roller_coaster)).to eq(nil)
      #this does not prove a random sample is being taken, will need ot refactor
    end
  end

  describe '#announce_lottery_winner' do
    it 'announces the lottery winner' do
      jeffco_fair = Carnival.new('Jefferson County Fair')
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
      ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
      scrambler = Ride.new({name: 'Scrambler', cost: 15})
      roller_coaster = Ride.new({name: 'Roller Coaster', cost: 77})
      bob = Attendee.new('Bob', 0)
      sally = Attendee.new('Sally', 20)
      lando = Attendee.new('Lando', 5)
      luke = Attendee.new('Luke', 10)

      jeffco_fair.add_ride(bumper_cars)
      jeffco_fair.add_ride(ferris_wheel)
      jeffco_fair.add_ride(scrambler)
      jeffco_fair.add_ride(roller_coaster)
      jeffco_fair.admit(bob)
      jeffco_fair.admit(sally)
      jeffco_fair.admit(lando)
      jeffco_fair.admit(luke)
      bob.add_interest('Ferris Wheel')
      bob.add_interest('Bumper Cars')
      sally.add_interest('Bumper Cars')
      lando.add_interest('Bumper Cars')
      luke.add_interest('Scrambler')

      expect(jeffco_fair.announce_lottery_winner(scrambler)).to eq('Luke won the lightsaber')
      expect(jeffco_fair.announce_lottery_winner(roller_coaster)).to eq('No winners for this lottery')
    end
  end
end
