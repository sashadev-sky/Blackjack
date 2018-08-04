require_relative 'deck'
require_relative 'player'
require_relative 'dealer'
require_relative 'hand'

class BlackjackGame
  attr_reader :players, :deck, :dealer, :player

  MIN_BET = 2
  MAX_BET = 500


  def initialize
    @player = player
    @players = []
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def play
    welcome_message
    deck.shuffle
    players << dealer
    until game_over?
      setup_round
      play_round
    end
    # end_game
  end

  def welcome_message
    @players.each do |player|
      next if player.is_a?(Dealer)
      puts "Welcome #{player.name}!"
    end
    puts "A new deck has been shuffled for you"
  end

  def play_round
    until round_over?
      players.each do |player|
        next if player.hand.busted?
        next if player.bankroll < MIN_BET
        get_player_move(player)

      end
    end
  end

  def setup_round
    players.each do |player|
      get_player_bet(player)
      player.deal_in(deck.deal_hand)
    end
    display_status
  end

  def get_player_move(player)
    print "#{player.name}: (h)it or (s)tand? > "
    move = player.select_move
    case move
    when "h" then
      player.hand.hit(deck)
      puts "Your new hand and count is #{player.hand}   (#{player.hand.points})"
    when "s" then
      puts "Your final hand and count for this round are #{player.hand}  (#{player.hand.points})"
    end
  end

  def display_status
    system("clear")
    puts "Dealer:    Hand: #{dealer.hand}  (Count: #{dealer.hand.points})   Current bet: N/A"
    puts "                             "
    players.each do |player|
      next if player.is_a?(Dealer)
      puts "#{player.name}:  Hand: #{player.hand}  (Count: #{player.hand.points})  Current bet: $#{dealer.bets[player]}"
      puts "- - - - - - - - - - - - - - - - - - - - - - - - - - - -"
    end

  end

  def get_player_bet(player)
    unless player.is_a?(Dealer)
      puts "Please enter a bet amount (min: $2, max: $500)"
      print "> "
      player.place_bet(dealer)
    end
  end

  def valid_bet?
  end

  def round_over?
    players.count { |player| !player.hand.busted? } <= 1 || players.any? { |player| player.hand.points == 21 }
  end

  def player_count
    players.select { |player| player.bankroll >= 2 }.count
  end


  def game_over?
    player_count <= 1
  end

  def add_player(name, buy_in)
    @player = Player.buy_in(name, buy_in)
    @players << @player
  end

end

if $PROGRAM_NAME == __FILE__
  g = BlackjackGame.new
  g.add_player("Player 1", 1_000)
  g.play
end
