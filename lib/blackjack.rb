require_relative 'deck'
require_relative 'player'
require_relative 'dealer'

class BlackjackGame
  attr_reader :players, :dealer, :player

  MIN_BET = 2
  MAX_PLAYERS = 3

  def initialize
    @player = player
    @players = []
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def play
    deck.shuffle
    welcome_message
    until all_bankrupt?
      setup_round
      play_round
      settle_round
    end
    end_game
  end

  def welcome_message
    system("clear")
    players.each do |player|
      puts "Welcome #{player.name}! You currently have $#{player.bankroll}"
      sleep(1)
      puts "                  "
    end
  end

  def settle_round
    dealer.pay_bets
    players.each do |player|
      puts "#{player.name}: Currently has $#{player.bankroll}"
      player.return_cards(deck)
    end
    dealer.reset_bets
    dealer.return_cards(deck)
    players.delete_if { |player| player.bankroll < 2 }
    deck.shuffle
  end

  def play_round
    players.each do |player|
      next if player.bankroll < MIN_BET
      next if player.points == 21
      get_player_move(player)
    end
    puts "....Dealer's move...." unless dealer.points == 21
    sleep(1)
    dealer.face_up
    display_status
    sleep(1)
    get_player_move(dealer) unless players.all? { |player| player.busted? }
    players.each { |player| player.bankroll -= player.bet_amt }
  end

  def setup_round
    players.each do |player|
      get_player_bet(player)
      player.deal_in(deck.deal_hand)
    end
    dealer.deal_in(deck.deal_hand)
    display_status
  end

  def get_player_move(player)
    if player.is_a?(Dealer)
      player.play_hand(deck)
      display_status
      sleep(1)
    else
      print "#{player.name}: (h)it or (s)tand? > "
      move = player.get_move
      case move
      when "h" then
        player.hit(deck)
        display_status
        get_player_move(player) unless player.points >= 21
      when "s" then
        display_status
      end
    end
  end

  def display_status
    system("clear")
    puts "Dealer:    Hand: #{dealer.hand}  (Count: #{dealer.points})   Current bet: N/A"
    puts "- - - - - - - - - - - - - - - - - - - - - - - - - - - -"
    players.each do |player|
      puts "#{player.name}:  Hand: #{player.hand}  (Count: #{player.points})  Current bet: $#{dealer.bets[player]}"
      puts "- - - - - - - - - - - - - - - - - - - - - - - - - - - -"
    end

  end

  def get_player_bet(player)
    puts "#{player.name}: Please enter a bet amount (min: $2)"
    print "> "
    player.place_bet(dealer)
  end


  def player_count
    players.select { |player| player.bankroll >= 2 }.count
  end


  def all_bankrupt?
    player_count == 0
  end

  def add_player(name, buy_in)
    if @players.count == MAX_PLAYERS
      system("clear")
      puts "                "
      puts "You tried to add more than 3 players: the maximum number is 3."
      sleep(3)
      puts "                "
      puts "The game will begin with the first three players added."
      sleep(4)
    else
      @player = Player.buy_in(name, buy_in)
      @players << @player
    end
  end

  def end_game
    abort("Sorry, all players do not have enough money to continue")
  end

  private

  attr_reader :deck

end

if $PROGRAM_NAME == __FILE__
  g = BlackjackGame.new
  g.add_player("Player 1", 1_000)
  g.add_player("Player 2", 1_000)
  g.add_player("Player 3", 1_000)
  g.add_player("Player 4", 1_000)
  g.play
end
