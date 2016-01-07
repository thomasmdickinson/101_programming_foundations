require_relative 'ttt_display_methods'
require_relative 'ttt_state_logic_methods'
require 'yaml'

MESSAGES = YAML.load_file('ttt_messages.yml')

# Set up the game
cells = {
  'a1' => 0, 'b1' => 1, 'c1' => 2,
  'a2' => 3, 'b2' => 4, 'c2' => 5,
  'a3' => 6, 'b3' => 7, 'c3' => 8
}

winning_lines = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8],
  [0, 3, 6], [1, 4, 7], [2, 5, 9],
  [0, 4, 9], [2, 4, 6]
]

# Welcome the Player
puts MESSAGES['welcome']
sleep 1

# Get their name
puts MESSAGES['name_ask']
player_name = ''
loop do
  player_name = gets.chomp.to_s
  break unless player_name == ''
  puts MESSAGES['bad_name']
end
puts "Okay, #{player_name}, let's get started!"
sleep 1

loop do # Main loop
  # Do they want to be X (go first) or O (go second)
  player_side = :x
  computer_side = :o
  loop do
    puts MESSAGES['pick_side']
    player_xo_choice = gets.chomp.downcase
    if player_xo_choice.start_with?('x')
      puts MESSAGES['player_pick_x']
      break
    elsif player_xo_choice.start_with?('o')
      player_side = :o
      computer_side = :x
      puts MESSAGES['player_pick_o']
      break
    else
      puts MESSAGES['player_pick_bad']
    end
  end
  sleep 1

  # Show them the board
  puts MESSAGES['set_board']
  sleep 1
  board = initialize_board
  display_board(board)
  sleep 1
  puts MESSAGES['explain_cell_ref']
  sleep 1

  loop do # Turn Loop
    # Player's Turn (skip if the board is empty and the player is o)
    unless board_empty?(board) && player_side == :o
      puts MESSAGES['your_turn']
      sleep 1

      # Ask for input
      player_input = ''
      player_cell = 0
      loop do
        puts MESSAGES['pick_cell']
        player_input = gets.chomp.downcase
        if !cells.key?(player_input)
          puts MESSAGES['bad_cell']
          sleep 1
        elsif !cell_empty?(board, cells, player_input)
          puts MESSAGES['taken_cell']
          sleep 1
        else
          player_cell = cells[player_input]
          break
        end
      end

      # Mark the board and show it to the player
      puts MESSAGES['adding_pick']
      sleep 1
      board[player_cell] = player_side
      display_board(board)
      sleep 1

      # Break the turn loop if the game is over
      break if game_over?(board, winning_lines)
    end

    # Computer's Turn
    puts MESSAGES['my_turn']
    sleep 1

    # Determine which one to mark
    puts MESSAGES['thinking']
    sleep 1
    computer_choice = ''
    loop do
      computer_choice = cells.keys.sample
      break if cell_empty?(board, cells, computer_choice)
    end

    # Mark the board and show it to the player
    puts "Okay, I pick #{computer_choice}."
    computer_cell = cells[computer_choice]
    board[computer_cell] = computer_side
    sleep 1
    display_board(board)
    sleep 1

    # Break the turn loop if the game is over
    break if game_over?(board, winning_lines)
  end

  # Announce results
  if who_won?(board, winning_lines) == player_side
    puts "#{player_name} wins!"
  elsif who_won?(board, winning_lines) == computer_side
    puts 'I won!'
  else
    puts "It's a tie!"
  end
  sleep 1

  # Play again?
  puts MESSAGES['again']
  answer = Kernel.gets.chomp
  break unless answer.downcase.start_with?('y')
end

# Goodbye
puts MESSAGES['farewell']
