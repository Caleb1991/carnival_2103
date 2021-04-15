require './lib/ride'

RSpec.describe Ride do

  describe 'initialize' do
    it 'exists' do
      ride = Ride.new({name: 'Ferris Wheel', cost: 0})

      expect(ride).to be_an_instance_of(Ride)
    end
  end
end
