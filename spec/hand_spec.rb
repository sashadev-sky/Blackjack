require 'rspec'
require 'hand'
require 'card'

describe Hand do
  describe "#points" do
    it "adds up normal cards" do
      hand = Hand.new([
          Card.new(:spades, :deuce),
          Card.new(:spades, :four)
        ])

      expect(hand.points).to eq(6)
    end

    it "counts an ace as 11 if it can" do
      hand = Hand.new([
          Card.new(:spades, :ten),
          Card.new(:spades, :ace)
        ])

      expect(hand.points).to eq(21)
    end

    it "counts some aces as 1 and others as 11" do
      hand = Hand.new([
          Card.new(:spades, :ace),
          Card.new(:spades, :six),
          Card.new(:hearts, :ace)
        ])

      expect(hand.points).to eq(18)
    end
  end

  describe "#hit" do
    it "draws a card from deck" do
      deck = double("deck")
      card = double("card")
      expect(deck).to receive(:take).with(1).and_return([card])

      hand = Hand.new([])
      hand.hit(deck)

      expect(hand.cards).to include(card)
    end
  end

  describe "#beats?" do
    it "returns true if other hand has fewer points" do
      hand1 = Hand.new([
          Card.new(:spades, :ace),
          Card.new(:spades, :ten)
        ])
      hand2 = Hand.new([
          Card.new(:hearts, :ace),
          Card.new(:hearts, :nine)
        ])

      expect(hand1.beats?(hand2)).to be(true)
      expect(hand2.beats?(hand1)).to be(false)
    end

    it "returns false if hands have equal points" do
      hand1 = Hand.new([
          Card.new(:spades, :ace),
          Card.new(:spades, :ten)
        ])
      hand2 = Hand.new([
          Card.new(:hearts, :ace),
          Card.new(:hearts, :ten)
        ])

      expect(hand1.beats?(hand2)).to be(false)
      expect(hand2.beats?(hand1)).to be(false)
    end

    it "returns false if busted" do
      hand1 = Hand.new([
          Card.new(:spades, :ten),
          Card.new(:hearts, :ten),
          Card.new(:clubs, :ten)
        ])
      hand2 = Hand.new([
          Card.new(:hearts, :deuce),
          Card.new(:hearts, :three)
        ])

      expect(hand1.beats?(hand2)).to be(false)
      expect(hand2.beats?(hand1)).to be(true)
    end
  end

  describe "#return_cards" do
    let(:deck) { double("deck") }
    let(:hand) do
      Hand.new([Card.new(:spades, :deuce), Card.new(:spades, :three)])
    end

    it "returns cards to deck" do
      expect(deck).to receive(:return) do |cards|
        expect(cards.count).to eq(2)
      end

      hand.return_cards(deck)
    end

    it "removes card from hand" do
      allow(deck).to receive(:return)

      hand.return_cards(deck)
      expect(hand.cards).to eq([])
    end
  end

end
