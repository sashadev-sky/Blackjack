require 'dealer'

describe Dealer do
  subject(:dealer) { Dealer.new }

  it "does not place bets" do
    expect do
      dealer.place_bet(dealer, 100)
    end.to raise_error("Dealer doesn't bet")
  end
