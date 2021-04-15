class Carnival
  attr_reader :name,
              :rides

  def initialize(name)
    @name = name
    @rides = []
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
end
