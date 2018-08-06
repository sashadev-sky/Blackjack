require_relative 'hand'

class Player
  attr_reader :name, :bet_amt
  attr_accessor :hand, :bankroll

  def self.buy_in(name, bankroll)
    Player.new(name, bankroll)
  end

  def initialize(name, bankroll)
    @name = name
    @bankroll = bankroll
  end

  def pay_winnings(bet_amt)
    @bankroll += bet_amt
  end

  def busted?
    hand.busted?
  end

  def points
    hand.points
  end

  def hit(deck)
    hand.hit(deck)
  end

  def deal_in(hand)
    @hand = hand
  end

  def get_move
    responce = gets.chomp.downcase[0]
    puts "                           "
    until responce == "h" || responce == "s"
      print "Try again. Please enter (h)it or (s)tand> "
      responce = gets.chomp.downcase[0]
    end
    responce
  end

  def return_cards(deck)
    hand.return_cards(deck)
    @hand = nil
  end

  def place_bet(dealer)
    begin
      @bet_amt = Integer(gets.chomp)
      if bet_amt > @bankroll
        raise RuntimeError, "Not enough money. Please place a lower bet"
      elsif bet_amt < 2
        raise RuntimeError, "Please bet at least $2"
      end
    rescue RuntimeError => e
      puts e.message
      print "> "
      retry
    rescue ArgumentError
      puts "Try again. Please enter your bet amount as a plain integer, leaving off currency or commas:"
      print "> "
      retry
    end
    dealer.take_bet(self, bet_amt)
  end

end
