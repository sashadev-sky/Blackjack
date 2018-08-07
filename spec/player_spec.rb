require 'player'

describe Player do
  subject(:player) do
    Player.new("Nick the Greek", 200_000)
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
