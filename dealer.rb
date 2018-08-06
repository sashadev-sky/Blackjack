require_relative 'player'
require_relative 'hand'

class Dealer < Player
  attr_reader :bets, :hand, :name

  def initialize
    @name = name
    name = "Dealer"
    @bets = {}
  end

  def place_bet(dealer, amt)
    raise "Dealer doesn't bet" if dealer.is_a?(Dealer)
  end

  def deal_in(hand)
    @hand = hand
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
        puts "#{player.name}: wins this hand"
        player.pay_winnings(bet * 2)
      else
        puts "#{player.name}: loses this hand"
      end
    end
  end

end
