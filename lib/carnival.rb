class Carnival
  attr_reader :name,
              :rides,
              :attendees

  def initialize(name)
    @name = name
    @rides = []
    @attendees = []
  end

  def add_ride(ride)
    @rides << ride
  end

  def recommend_rides(attendee)
    attendee_interests = attendee.interests

    reccomendations = attendee_interests.map do |interest|
      @rides.find_all do |ride|
        interest == ride.name
      end
    end.flatten
  end

  def admit(attendee)
    @attendees << attendee
  end
end
