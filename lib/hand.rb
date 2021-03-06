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
      next if card.revealed == false
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

  def face_down
    @cards.last.revealed = false
  end

  def face_up
    @cards.last.revealed = true
  end

  def hit(deck)
    raise "already busted" if busted?
    @cards.concat(deck.take(1))
  end

  def beats?(other_hand)
    # busted hand -> loss
    return false if self.busted?

    #given that your hand is not busted, if you have more points than the
    #dealer or the dealers hand is busted, its a win.
    (other_hand.busted?) || (self.points > other_hand.points)
  end

  def return_cards(deck)
    deck.return(@cards)
    @cards = []
  end

  def to_s
    @cards.join(",")
  end
end
