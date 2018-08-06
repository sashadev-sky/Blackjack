require_relative 'card'

class Hand

  def self.deal_from(deck)
    Hand.new(deck.take(2))
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def points
    points_count = 0
    ace = 0

    @cards.each do |card|
      case card.value
      when :ace
        points_count += 11
        ace += 1
      else
        points_count += card.blackjack_value
      end
    end

    ace.times do
      points_count -= 10 if points_count > 21
    end

    points_count

  end

  def busted?
    points > 21
  end

  def hit(deck)
    raise "already busted" if busted?
    @cards.concat(deck.take(1))
  end

  def beats?(other_hand)
    if self.busted?
      # puts "You have busted"
      return false
    elsif self.points < other_hand.points && !(other_hand.busted?)
      # puts "Dealer wins this round!"
      return false
    elsif self.points == other_hand.points && !self.busted?
      # puts "Dealer wins all ties, you lose this round!"
      return false
    elsif self.points > other_hand.points && !(self.busted?)
      # puts "You win this round"
      return true
    elsif !(self.busted?) && other_hand.busted?
      # puts "The dealer has busted. You win this round"
      return true
    end
  end

  def return_cards(deck)
    deck.return(@cards)
    @cards = []
  end

  def to_s
    @cards.join(",")
  end
end
