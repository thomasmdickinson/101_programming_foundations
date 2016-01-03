VALID_CHOICES = ['rock', 'paper', 'scissors']

def test_method
  prompt('test message')
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def display_result(player, computer)
  if (player == 'rock' && computer == 'scissors') ||
      (player == 'paper' && computer == 'rock') ||
      (player == 'scissors' && computer == 'paper')
    prompt("You won!")
  elsif (player == 'rock' && computer == 'paper') ||
      (player == 'paper' && computer == 'scissors') ||
      (player == 'scissors' && computer == 'rock')
    prompt("You lost!")
  else
    prompt("It's a tie.")
  end
end

player_choice = ''

loop do # Main loop
  loop do
    prompt("Please choose one: #{VALID_CHOICES.join(', ')}")
    player_choice = Kernel.gets().chomp().downcase

    if VALID_CHOICES.include?(player_choice)
      break
    else
      prompt("That's not a valid choice!")
    end
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose #{player_choice}. Computer chose #{computer_choice}.")

  display_result(player_choice, computer_choice)

  prompt("Play again? Y/N")
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
end
prompt("Okay, bye!")
