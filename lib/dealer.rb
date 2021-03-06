require_relative 'player'
require_relative 'hand'

class Dealer < Player
  attr_reader :bets, :hand, :name

  def initialize
    @name = name
    name = "Dealer"
    @bets = {}
  end

  def play_hand(deck)
    hit(deck) until points >= 17
  end


  def deal_in(hand)
    @hand = hand
    @hand.face_down
  end

  def face_up
    @hand.face_up
  end

  def take_bet(player, amt)
    @bets[player] = amt
  end

  def reset_bets
    @bets = {}
  end

  def pay_bets
    @bets.each do |player, bet|
      if player.hand.beats?(self.hand)
        puts "#{player.name}: Wins this hand"
        player.pay_winnings(bet * 2)
      else
        puts "#{player.name}: Loses this hand"
      end
    end
  end

end
