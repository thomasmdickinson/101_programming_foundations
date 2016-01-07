def initialize_board
  board = []
  9.times { board << nil }
  board
end

# Board State Checks

def board_full?(state)
  state.each do |cell|
    return false if cell.nil?
  end
end

def board_empty?(state)
  state.each { |cell| return false unless cell.nil? }
end

def cell_empty?(state, list_of_cells, cell_ref)
  state[list_of_cells[cell_ref]].nil?
end

# Game State Checks

def game_over?(state, win_conditions)
  did_someone_win?(state, win_conditions) || board_full?(state)
end

def did_someone_win?(state, win_conditions)
  !!who_won?(state, win_conditions)
end

def who_won?(state, win_conditions)
  win_conditions.each do |line|
    if [state[line[0]], state[line[1]], state[line[2]]].uniq.size == 1
      return state[line[0]]
    end
  end
  false
end
