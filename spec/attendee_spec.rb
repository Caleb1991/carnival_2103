require './lib/attendee'
requrie './lib/ride'

RSpec.describe Attendee do

  describe 'initialize' do
    it 'exists' do
      attendee = Attendee.new('Bob', 20)

      expect(attendee).to be_an_instance_of(Attendee)
    end
  end
end
