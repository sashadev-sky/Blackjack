require 'rspec'
require 'dealer'

describe Dealer do
  subject(:dealer) { Dealer.new }

  describe "#play_hand" do
    let(:dealer_hand) { double("hand") }
    let(:deck) { double("deck") }

    before do
      dealer.hand = dealer_hand
    end

    it "does not hit on seventeen" do
      points = 17
      allow(dealer_hand).to receive(:points) { points }

      expect(dealer_hand).not_to receive(:hit)

      dealer.play_hand(deck)
    end

    it "hits until seventeen" do
      points = 12
      allow(dealer_hand).to receive(:points) { points }

      expect(dealer_hand).to receive(:hit).with(deck).exactly(3).times do
        points += 2
      end

      dealer.play_hand(deck)
    end

    it "stops when busted" do
      points = 16
      allow(dealer_hand).to receive(:points) { points }

      expect(dealer_hand).to receive(:hit).once.with(deck) { points = 22 }

      dealer.play_hand(deck)
    end
  end

  context "with a player" do
    let(:player) { double("player") }
    let(:dealer_hand) { double("hand") }
    let(:player_hand) { double("hand") }

    before(:each) do
      dealer.hand = dealer_hand
      allow(player).to receive(:hand) { player_hand }

      dealer.take_bet(player, 100)
    end

    it "records bets" do
      expect(dealer.bets).to eq({ player => 100 })
    end

    it "does not pay losers (or ties)" do
      expect(player_hand).to receive(:beats?).with(dealer_hand).and_return(false)
      expect(player).to receive(:name)
      expect(player).not_to receive(:pay_winnings)

      dealer.pay_bets
    end

    it "does pay winners" do
      expect(player_hand).to receive(:beats?).with(dealer_hand).and_return(true)
      expect(player).to receive(:name)

      expect(player).to receive(:pay_winnings).with(200)

      dealer.pay_bets
    end
  end



end
