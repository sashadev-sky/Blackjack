# Blackjack

- Terminal version of the classic Blackjack card game written in Ruby. Please note specific house rules outlined on this page

## Overview

- Run the command `bundle install` in your terminal
- To play,  then run `ruby lib/blackjack.rb` in your terminal
- This game supports multiple players: currently it is set to one player vs. a dealer
  - To add more, utilize the `add_player` method in the `blackjack.rb` file and save your changes before running the game
  - Reference the commented out `add_player` invocations at the bottom of the file as an example

## Testing
  - Written in RSpec
  - To test all at once: run command `bundle exec rspec`
  - To test individual spec files:
    - run, for ex: `bundle exec rspec ./spec/dealer_spec.rb`

## House Rules
- Each player starts with a bankroll of $1000
- Each round begins with players entering their bets
  - The minimum bet is $2
  - The maximum is equal to the current value of the players bankroll
- The deck is shuffled prior to each round
- 2 cards are dealt to each player and the dealer from a standard deck of 52 cards
  - The dealer's 2nd card will be face down until the players complete their turns
  - An ace counts as a 1 or 11
  - Face cards are 10 and any other card is its pip value
- The dealer will always hit until the value of their hand is >= 17 points
- Players play against the dealer - multiple players can win
  - If a player's hand is not busted (over 21) and has a higher score than the dealer, the player will receive their bet double at the end of the round
  - Otherwise, the player will lose the amount they bet (ties with the dealer are considered a loss)
- Bets are reset after each round
- If a player goes bankrupt, they are out of the game
- Rounds are unlimited and the game is only over when all of the players go bankrupt (in this case, when they can't afford the minimum bet of $2)

#### Ruby Concepts (personal use)
- RSpec
  - Unit Testing
    - Method doubles
    - Cases where the `dup` method is vital
    - `respond_to` for checking if variables are exposed
- `send` method
- `colorize` gem
  - `background` argument for rendering cards
- Freezing constants
- Overriding `==`
- Overriding `to_s`
- Class inheritance
- `product` method - to create a deck of cards
- splat operator - to return cards to deck w/out nested arrays
- `shift(n)` method
