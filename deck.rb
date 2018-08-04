require_relative 'card'
require_relative 'hand'

class Deck
  def self.all_cards
    Card.suits.product(Card.values).map do |suit, val|
      Card.new(suit, val)
    end
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  def deal_hand
    Hand.new(take(2))
  end

  def count
    @cards.count
  end

  def take(n)
    raise "not enough cards" if count < n
    @cards.shift(n)
  end

  def return(cards)
    @cards.push(*cards)
  end

  def shuffle
    @cards.shuffle!
  end
end
