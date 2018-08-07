require 'card'
require 'deck'

describe Deck do
  describe "::all_cards" do
    subject(:all_cards) { Deck.all_cards }

    it "starts with a count of 52" do
      expect(all_cards.count).to eq(52)
    end

    it "returns all cards without duplicates" do
      all_card_vals = Card.suits.product(Card.values).sort

      deduped_cards = all_cards
        .map { |card| [card.suit, card.value] }
        .sort

      expect(deduped_cards).to eq(all_card_vals)
    end
  end

  let(:cards) do
    cards = [
      Card.new(:spades, :king),
      Card.new(:spades, :queen),
      Card.new(:spades, :jack)
    ]
  end
  let(:deck) do
    Deck.new(cards.dup)
  end

  describe "#take" do
    # **use the front of the cards array as the top**
    it "takes cards off the top of the deck" do
      expect(deck.take(1)).to eq(cards[0..0])
      expect(deck.take(2)).to eq(cards[1..2])
    end

    it "removes cards from deck on take" do
      deck.take(2)
      expect(deck.count).to eq(1)
    end


    it "doesn't allow you to take more cards than are in the deck" do
      expect do
        deck.take(4)
      end.to raise_error("not enough cards")
    end
  end

  describe "#return" do
    let(:more_cards) do
      [ Card.new(:hearts, :four),
        Card.new(:hearts, :five),
        Card.new(:hearts, :six) ]
    end

    it "returns cards to the deck" do
      deck.return(more_cards)
      expect(deck.count).to eq(6)
    end

    it "adds new cards to the bottom of the deck" do
      deck.return(more_cards)
      deck.take(3) # toss 3 cards away

      expect(deck.take(1)).to eq(more_cards[0..0])
      expect(deck.take(1)).to eq(more_cards[1..1])
      expect(deck.take(1)).to eq(more_cards[2..2])
    end
  end

end
