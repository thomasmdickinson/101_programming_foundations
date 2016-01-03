VALID_CHOICES = %w(rock paper scissors lizard spock)

def prompt(message)
  Kernel.puts("=> #{message}")
end

# Bonus Feature 1 - allows for lizard and spock
def win?(first, second)
  (first == 'rock' && (second == 'scissors' || second == 'lizard')) ||
    (first == 'paper' && (second == 'rock' || second == 'spock')) ||
    (first == 'scissors' && (second == 'paper' || second == 'lizard')) ||
    (first == 'lizard' && (second == 'paper' || second == 'spock')) ||
    (first == 'spock' && (second == 'scissors' || second == 'rock'))
end

def display_result(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("You lost!")
  else
    prompt("It's a tie.")
  end
end

# Bonus feature 3 - score tracking
def display_score(player_name, player_score, computer_score)
  prompt("The current score is #{player_name}: #{player_score}, Computer: #{computer_score}")
end

# Bonus Feature 2 - allows for partial input
def translate_input(input)
  if input.start_with?('r')
    'rock'
  elsif input.start_with?('p')
    'paper'
  elsif input.start_with?('l')
    'lizard'
  elsif input.start_with?('sc')
    'scissors'
  elsif input.start_with?('sp')
    'spock'
  elsif input.start_with?('s')
    's'
  else
    'invalid choice'
  end
end

player_choice = ''
player_name = ''
player_score = 0
computer_score = 0

prompt("Welcome to R.P.S.L.S.!")
sleep(1)
prompt("Please tell me your name.")

loop do
  player_name = Kernel.gets().chomp()

  if player_name.empty?()
    prompt("No, really, please tell me your name.")
  else
    break
  end
end

prompt("Well hello, there, #{player_name}. Let's begin.")
sleep(1)
loop do # Main loop
  loop do
    prompt("Please choose one: #{VALID_CHOICES.join(', ')}")
    player_choice = translate_input(Kernel.gets().chomp().downcase)

    if VALID_CHOICES.include?(player_choice)
      break
    elsif player_choice == 's'
      prompt("You'll have to specify at least 'sp' for spock or 'sc' for scissors!")
      sleep(1)
    else
      prompt("That's not a valid choice!")
      sleep(1)
    end
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose #{player_choice}. Computer chose #{computer_choice}.")
  sleep(1)

  display_result(player_choice, computer_choice)
  sleep(1)

  if win?(player_choice, computer_choice)
    player_score += 1
    prompt("Point to #{player_name}!")
  elsif win?(computer_choice, player_choice)
    computer_score += 1
    prompt("Point to the computer!")
  else
    prompt("No poins awarded.")
  end

  sleep(1)
  display_score(player_name, player_score, computer_score)
  if player_score >= 5
    sleep(1)
    prompt("Hey, you got five points, so you're the champ!")
    sleep(1)
    prompt("If you want to keep playing, I can reset both scores to zero. A fresh start!")
    player_score = 0
    computer_score = 0
  elsif computer_score >= 5
    sleep(1)
    prompt("Hey, I got five points. Looks like I'm the new champ!")
    sleep(1)
    prompt("If you want to keep playing, I can reset both scores to zero. A fresh start!")
    player_score = 0
    computer_score = 0
  end

  sleep(1)
  prompt("Play again? Y/N")
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
end
prompt("Okay, bye!")
