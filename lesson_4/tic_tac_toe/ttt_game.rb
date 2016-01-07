require_relative 'ttt_methods.rb'
require 'yaml'
require 'pry'

MESSAGES = YAML.load_file('ttt_messages.yml')

# Set up the game
board = [
  [nil, nil, nil],
  [nil, nil, nil],
  [nil, nil, nil]
]

player_side = :x
computer_side = :o
player_name = ''

cells = {
  'a1' => [0, 0], 'a2' => [1, 0], 'a3' => [2, 0],
  'b1' => [0, 1], 'b2' => [1, 1], 'b3' => [2, 1],
  'c1' => [0, 2], 'c2' => [1, 2], 'c3' => [2, 2]
}

# Welcome the Player
puts MESSAGES['welcome']
sleep 1

# Get their name
puts MESSAGES['name_ask']
loop do
  player_name = gets.chomp.to_s
  break unless player_name == ''
  puts MESSAGES['bad_name']
end

puts "Okay, #{player_name}, let's get started!"
sleep 1

loop do # Main loop
  # Do they want to be X (go first) or O (go second)
  loop do
    puts MESSAGES['pick_side']
    player_xo_choice = gets.chomp.downcase
    if player_xo_choice.start_with?('x')
      player_side = :x
      computer_side = :o
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
  board = [
    [nil, nil, nil],
    [nil, nil, nil],
    [nil, nil, nil]
  ]
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
      player_row = 0
      player_col = 0
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
          player_row = cells[player_input][0]
          player_col = cells[player_input][1]
          break
        end
      end

      # Mark the board and show it to the player
      puts MESSAGES['adding_pick']
      sleep 1
      board[player_row][player_col] = player_side
      display_board(board)
      sleep 1

      # Break the turn loop if the game is over
      break if game_over?(board)
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
    computer_row = cells[computer_choice][0]
    computer_col = cells[computer_choice][1]
    board[computer_row][computer_col] = computer_side
    sleep 1
    display_board(board)
    sleep 1

    # Break the turn loop if the game is over
    break if game_over?(board)
  end

  # Announce results
  if check_for_winner(board) == player_side
    puts "#{player_name} wins!"
  elsif check_for_winner(board) == computer_side
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
