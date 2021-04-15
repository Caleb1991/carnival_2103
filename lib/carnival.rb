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

  def attendees_by_ride_interest
    hash = {}

    @rides.each do |ride|
      hash[ride] = []
    end

    @rides.each do |ride|
      @attendees.each do |attendee|
        if recommend_rides(attendee).include?(ride)
        hash[ride] << attendee
        end
      end
    end
    hash
  end

  def ticket_lottery_contestants(ride)
    @attendees.find_all do |attendee|
      recommend_rides(attendee).include?(ride) && attendee.spending_money < ride.cost
    end
  end
end
