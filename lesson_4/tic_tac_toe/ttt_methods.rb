# Returns a string suitable for display.
def cell_string(cell_ref)
  if cell_ref == :x
    ' X '
  elsif cell_ref == :o
    ' O '
  else
    '   '
  end
end

# Returns a row string, consisting of cell strings, suitable for display.
def row_string(state, row_num)
  row = '|'
  (0..2).each do |idx|
    row << cell_string(state[row_num][idx])
    row << '|'
  end
  row
end

# Prints the board.
def display_board(state)
  top_bottom      = '   ----------- '
  row_boundary    = '  |---|---|---|'
  puts '    A   B   C  '
  puts top_bottom
  puts '1 ' + row_string(state, 0)
  puts row_boundary
  puts '2 ' + row_string(state, 1)
  puts row_boundary
  puts '3 ' + row_string(state, 2)
  puts top_bottom
end

def check_for_horizontal_win(state)
  state.each { |row| return row[0] if [row[0], row[1], row[2]].uniq.size == 1 }
  false
end

def check_for_vertical_win(state)
  (0..2).each do |col|
    if [state[0][col], state[1][col], state[2][col]].uniq.size == 1
      return state[0][col]
    end
  end
  false
end

def diagonal_a(state)
  [state[0][0], state[1][1], state[2][2]]
end

def diagonal_b(state)
  [state[0][2], state[1][1], state[2][0]]
end

def check_for_diagonal_win(state)
  if diagonal_a(state).uniq.size == 1 || diagonal_b(state).uniq.size == 1
    return state[1][1]
  end
  false
end

def check_for_winner(state)
  return check_for_horizontal_win(state) if check_for_horizontal_win(state)
  return check_for_vertical_win(state) if check_for_vertical_win(state)
  check_for_diagonal_win(state)
end

def board_full?(state)
  state.each do |row|
    row.each do |cell|
      return false if cell.nil?
    end
  end
end

def board_empty?(state)
  state.each do |row|
    row.each do |cell|
      return false unless cell.nil?
    end
  end
end

def game_over?(state)
  if check_for_winner(state)
    true
  elsif board_full?(state)
    true
  else
    false
  end
end

def cell_empty?(state, list_of_cells, cell_ref)
  state[list_of_cells[cell_ref][0]][list_of_cells[cell_ref][1]].nil?
end
