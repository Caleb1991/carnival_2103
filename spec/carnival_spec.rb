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
  end

  describe '#add_ride' do
    it 'can add a ride' do
      jeffco_fair = Carnival.new('Jefferson County Fair')
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})

      jeffco_fair.add_ride(bumper_cars)

      expect(jeffco.rides).to eq([bumper_cars])
    end
  end
end
