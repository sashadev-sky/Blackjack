require_relative 'player'
require_relative 'hand'

class Dealer < Player
  attr_reader :bets, :hand

  def initialize
    super("dealer", 100_000)

    @bets = {}
  end

  def place_bet(dealer, amt)
    raise "Dealer doesn't bet" if dealer.is_a?(Dealer)
  end

  def deal_in(hand)
    @hand = hand
    @hand.face_down
  end

  def play_hand(deck)
    until hand.points >= 17 || hand.busted?
      hand.hit(deck)
    end
  end

  def take_bet(player, amt)
    @bets[player] = amt
  end

  def pay_bets
    @bets.each do |player, bet|
      if player.hand.beats?(self.hand)
        player.pay_winnings(bet * 2)
      end
    end
  end
end
