require 'rspec'
require 'blackjack'

describe BlackjackGame do
  subject(:game) { BlackjackGame.new }

  describe '#add_player' do
    it 'should create a player' do
      game.add_player("player1", 1000)
        expect(game.players.first).to be_a(Player)
    end

    it 'should set the players bankrolls' do
      game.add_player("player1", 1000)
      game.add_player("player2", 1000)
      game.add_player("player3", 1000)
      expect(
        game.players.all? { |player| player.bankroll == 1000 }
      ).to be(true)
      end
    end

  describe '#all_bankrupt?' do
    it 'should return false when players still have money' do
      game.add_player("player1", 1000)
      expect(game).not_to be_all_bankrupt
    end


    it 'should return true when all players do not have at least 2 dollars' do
      game.add_player("player1", 0)
      game.add_player("player2", 1)
      game.add_player("player3", 1)
      expect(game).to be_all_bankrupt
    end
  end

end
