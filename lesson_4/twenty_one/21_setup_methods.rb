#### GAME FLOW

def initialize_deck
  deck = []
  SUITS.each do |st|
    VALUES.each do |vl|
      card = { suit: st, value: vl, points: card_points(vl), secret: false }
      deck << card
    end
  end
  deck
end

def prompt(msg)
  puts "=> #{msg}"
end

def deal_card(deck, hand)
  deck.shuffle!
  hand << deck.pop
end

def announce_hand(hand, player_name)
  prompt "#{player_name} has the following cards:"
  sleep 1
  hand.each do |card|
    if card[:secret] == true
      prompt ':: Face down card'
    else
      prompt ":: #{card[:value]} of #{card[:suit]}"
    end
    sleep 1
  end
end

def announce_score(hand, name)
  prompt "#{name}'s score is #{hand_total(hand)}."
  sleep 1
end

def announce_dealer_bust(hand, name)
  prompt "Oh, botheration! I've gone and busted."
  sleep 1
  hand.each do |card|
    if card[:secret] == true
      prompt "I had a hidden #{card[:value]} of #{card[:suit]}."
      sleep 1
    end
  end
  prompt "So my score was #{hand_total(hand)}! Too high, I'm afraid."
end

### COMPUTATIONS

def card_points(value)
  if value.to_i > 0
    return value
  elsif value == 'Ace'
    return 11
  else
    return 10
  end
end

def reduce_aces(hand, score)
  high_aces = 0
  hand.each { |card| high_aces += 1 if card[:value] == 'Ace' }
  loop do
    break unless score > 21 && high_aces > 0
    score -= 10
    high_aces -= 1
  end
  score
end

def hand_total(hand)
  total = 0
  hand.each { |card| total += card[:points] }
  total = reduce_aces(hand, total)
  total
end

def bust?(hand)
  hand_total(hand) > 21
end

def dealer_stay?(hand)
  hand_total(hand) >= 17
end

def winner(hand1, name1, hand2, name2)
  winner_name = ''
  if bust?(hand1)
    winner_name = name2
  elsif bust?(hand2)
    winner_name = name1
  elsif hand_total(hand1) > hand_total(hand2)
    winner_name = name1
  elsif hand_total(hand1) < hand_total(hand2)
    winner_name = name2
  end
  winner_name
end
