require 'rspec'
require 'player'

describe Player do
  subject(:player) { Player.new("player1", 200_000) }

  describe '::buy_in' do
    it  'creates a player' do
      expect(Player.buy_in("player1", 100)).to be_a(Player)
    end

    it 'sets the players bankroll' do
      expect(Player.buy_in("player2", 100).bankroll).to eq(100)
    end
  end

  describe '#deal_in' do
    let(:hand) { double ('hand') }

    it 'sets the players hand' do
      player.deal_in(hand)
      expect(player.hand).to eq(hand)
    end
  end

  describe "#pay_winnings" do
    it "adds to winnings" do
      player.pay_winnings(200)

      expect(player.bankroll).to eq(200_200)
    end
  end

  describe "#return_cards" do
    let(:deck) { double("deck") }
    let(:hand) { double("hand") }

    before(:each) do
      player.hand = hand
    end

    it "returns player's cards to the deck" do
      expect(hand).to receive(:return_cards).with(deck)
      player.return_cards(deck)
    end

    it "resets hand to nil" do
      expect(hand).to receive(:return_cards).and_return(nil)
      player.return_cards(deck)
    end
  end
end
