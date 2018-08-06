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

    it "hits until seventeen acheived" do
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



end
