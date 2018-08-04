class Player
  attr_reader :name, :bankroll
  attr_accessor :hand

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

  def deal_in(hand)
    @hand = hand
  end

  def select_move
    responce = gets.chomp.downcase[0]  
  end

  def return_cards(deck)
    hand.return_cards(deck)
    @hand = nil
  end

  def place_bet(dealer)
    begin
      bet_amt = Integer(gets.chomp)
      raise RuntimeError, "Not enough money. Please place a lower bet" if bet_amt > @bankroll
    rescue RuntimeError => e
      puts e.message
      retry
    rescue ArgumentError
      puts "Try again. Please enter your bet amount as a plain integer, leaving off currency or commas:"
      print "> "
      retry
    end
    dealer.take_bet(self, bet_amt)
    @bankroll -= bet_amt
  end

end
