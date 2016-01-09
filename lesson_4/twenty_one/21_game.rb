require_relative '21_setup_methods'

SUITS = %w(Hearts Diamonds Clubs Spades)
VALUES = (2..10).to_a + %w(Jack Queen King Ace)
dealer_name = 'Mr. Dealer'

# Welcome
prompt 'Welcome to 21!'
sleep 1
prompt "What's your name?"
player_name = gets.chomp

prompt "Let's get started, #{player_name}!"
sleep 1

# Main loop
loop do
  # Setting the game up
  deck = initialize_deck
  player_hand = []
  dealer_hand = []

  # Deal cards
  prompt 'Shuffling the deck...'
  sleep 1
  prompt 'Dealing the cards...'
  sleep 1
  2.times { deal_card(deck, player_hand) }
  2.times { deal_card(deck, dealer_hand) }
  dealer_hand.first[:secret] = true
  announce_hand(player_hand, player_name)
  announce_hand(dealer_hand, dealer_name)
  announce_score(player_hand, player_name)

  # Player turn
  loop do
    # Hit or stay?
    player_choice = ''
    loop do
      prompt 'Hit or stay?'
      player_choice = gets.chomp.downcase
      break if player_choice == 'hit' || player_choice == 'stay'
      prompt "That's not a thing."
      sleep 1
    end

    if player_choice == 'hit'
      prompt 'All right, dealing card...'
      sleep 1
      deal_card(deck, player_hand)
      announce_hand(player_hand, player_name)
      announce_score(player_hand, player_name)
    elsif player_choice == 'stay'
      prompt 'Okay, you stay.'
      sleep 1
      break
    end

    if bust?(player_hand)
      prompt 'Sorry, looks like you busted.'
      sleep 1
      break
    end
  end

  # Dealer turn
  unless bust?(player_hand)
    prompt "Now it's my turn!"
    sleep 1

    loop do
      # Hit or stay?
      if dealer_stay?(dealer_hand)        # STAY
        prompt "Hmm... I'm going to stay."
        sleep 1
        break
      else                                # HIT
        prompt "I'll hit."
        sleep 1
        deal_card(deck, dealer_hand)
        announce_hand(dealer_hand, dealer_name)
      end

      if bust?(dealer_hand)
        prompt "Oh, botheration! I've gone and busted."
        sleep 1
        dealer_hand.first[:secret] = false
        announce_hand(dealer_hand, dealer_name)
        announce_score(dealer_hand, dealer_name)
        break
      end
    end
  end

  # Reveal dealer's hand
  unless bust?(player_hand) || bust?(dealer_hand)
    prompt "I'll reveal my hand now."
    sleep 1
    dealer_hand.first[:secret] = false
    announce_hand(dealer_hand, dealer_name)
    announce_score(dealer_hand, dealer_name)
    prompt 'And what was your score? Ah yes.'
    sleep 1
    announce_score(player_hand, player_name)
  end

  # Reveal winner
  game_winner = winner(player_hand, player_name, dealer_hand, dealer_name)
  prompt "#{game_winner} is the winner!"
  sleep 1
  prompt 'Play again?'
  again_answer = Kernel.gets.chomp
  break unless again_answer.downcase.start_with?('y')
end
