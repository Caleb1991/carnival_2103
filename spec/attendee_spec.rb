require './lib/attendee'
require './lib/ride'

RSpec.describe Attendee do

  describe 'initialize' do
    it 'exists' do
      attendee = Attendee.new('Bob', 20)

      expect(attendee).to be_an_instance_of(Attendee)
    end

    it 'has a name' do
      attendee = Attendee.new('Bob', 20)

      expect(attendee.name).to eq('Bob')
    end

    it 'has spending money' do
      attendee = Attendee.new('Bob', 20)

      expect(attendee.spending_money).to eq(20)
    end

    it 'has no interests by default' do
      attendee = Attendee.new('Bob', 20)

      expet(attendee.interests).to eq([])
    end
  end
end
