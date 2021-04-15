require './lib/attendee'
requrie './lib/ride'

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
  end
end
