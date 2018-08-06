# Blackjack

- Terminal version of the classic Blackjack card game written in Ruby. Please note specific house rules outlined on this page

## Overview

- To play, run the command `ruby lib/blackjack.rb` in your terminal
- This game supports multiple players: currently it is set to one player vs. a dealer
  - To add more, utilize the `add_player` method in the `blackjack.rb` file and save your changes before running the game
  - Reference the commented out call to `add_player` at the bottom of the file as an example

## House Rules
- Each player starts with a bankroll of $1000
- Each player enters an initial bet before each round
  - The minimum bet is $2
  - The maximum is equal to the current value of the players bankroll
- The deck is shuffled prior to each round to prevent counting cards
- 2 cards are dealt to each player and the dealer from a standard deck of 52 cards
  - An ace counts as a 1 or 11
  - Face cards are 10 and any other card is its pip value
-  Players play against the dealer
  - If a player's hand is not busted (over 21) and has a higher score than the dealer, the player will receive their bet double at the end of the round
  - Otherwise, the player will lose the amount they bet (ties with the dealer are considered a loss)
- Bets are reset after each round
- If a player goes bankrupt, they are out of the game
- Rounds are unlimited and the game is only over when all of the players go bankrupt (in this case, when they can't afford the minimum bet of $2)
