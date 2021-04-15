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

  def draw_lottery_winner(ride)
    winner = ticket_lottery_contestants(ride).sample
    if winner != nil
      winner.name
    end
  end

  def announce_lottery_winner(ride)
    winner = draw_lottery_winner(ride)

    if winner != nil
      "#{winner} won the lightsaber"
    else
      'No winners for this lottery'
    end
  end
end
