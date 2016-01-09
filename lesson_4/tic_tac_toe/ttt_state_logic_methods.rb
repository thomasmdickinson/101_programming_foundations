def initialize_board
  board = []
  9.times { board << nil }
  board
end

def idx_to_rowcol(int, ref_table)
  ref_table.key(int)
end

def rowcol_to_idx(ref, ref_table)
  ref_table[ref]
end

# Board State Checks

def board_full?(state)
  state.none?(&:nil?)
end

def board_empty?(state)
  state.all?(&:nil?)
end

def cell_empty?(state, cell)
  state[cell].nil?
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
