require 'rspec'
require 'hand'

describe Hand do
  let(:cards) do
      [ double("card", :suit => :spades, :value => :deuce, :revealed => true, :blackjack_value => 2),
        double("card", :suit => :spades, :value => :four, :revealed => true, :blackjack_value => 4)]
  end

  subject(:hand) { Hand.new(cards) }

  describe '#initialize' do
    it 'accepts cards correctly' do
      expect(hand.cards).to match_array(cards)
    end
  end

  describe "#points" do
    let(:high_ace_cards) do
      [ double("card", :suit => :spades, :value => :ten, :revealed => true, :blackjack_value => 10),
        double("card", :suit => :spades, :value => :ace, :revealed => true, :blackjack_value => 11)]
    end

    let(:low_ace_cards) do
      [ double("card", :suit => :spades, :value => :ace, :revealed => true, :blackjack_value => 11),
        double("card", :suit => :spades, :value => :six, :revealed => true, :blackjack_value => 6),
        double("card", :suit => :hearts, :value => :ace, :revealed => true, :blackjack_value => 1)]
    end

    it "adds up normal cards" do
      expect(hand.points).to eq(6)
    end

    it "counts an ace as 11 if it can" do
      hand = Hand.new(high_ace_cards)
      expect(hand.points).to eq(21)
    end

    it "counts some aces as 1 and others as 11" do
      hand = Hand.new(low_ace_cards)

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
      hand2 = Hand.new([
        double("card", :suit => :spades, :value => :deuce, :revealed => true, :blackjack_value => 2),
        double("card", :suit => :spades, :value => :three, :revealed => true, :blackjack_value => 3)
        ])

      expect(hand.beats?(hand2)).to be(true)
      expect(hand2.beats?(hand)).to be(false)
    end

    it "returns false if hands have equal points" do
      hand2= Hand.new([
        double("card", :suit => :hearts, :value => :deuce, :revealed => true, :blackjack_value => 2),
        double("card", :suit => :hearts, :value => :four, :revealed => true, :blackjack_value => 4)
      ])

      expect(hand.beats?(hand2)).to be(false)
      expect(hand2.beats?(hand)).to be(false)
    end

    it "returns false if busted" do
      hand2= Hand.new([
        double("card", :suit => :spades, :value => :ten, :revealed => true, :blackjack_value => 10),
        double("card", :suit => :hearts, :value => :ten, :revealed => true, :blackjack_value => 10),
        double("card", :suit => :clubs, :value => :ten, :revealed => true, :blackjack_value => 10)
      ])

      expect(hand2.beats?(hand)).to be(false)
      expect(hand.beats?(hand2)).to be(true)
    end
  end

  describe "#return_cards" do
    let(:deck) { double("deck") }

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
