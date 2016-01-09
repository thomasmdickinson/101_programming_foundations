def line_ready_for_win?(state, line, side)
  line_values = [state[line[0]], state[line[1]], state[line[2]]]
  return true if line_values.count(nil) == 1 && line_values.count(side) == 2
  false
end

def near_wins_on_board(state, win_conditions, side)
  near_wins = []
  win_conditions.each do |line|
    near_wins << line if line_ready_for_win?(state, line, side)
  end
  near_wins
end

def can_win?(state, win_conditions, side)
  !near_wins_on_board(state, win_conditions, side).empty?
end

def possible_forks(state, win_conditions, side)
  list_of_possible_forks = []
  (0..8).each do |num|
    next unless state[num].nil?
    hypothetical_state = state.clone
    hypothetical_state[num] = side
    if near_wins_on_board(hypothetical_state, win_conditions, side).size >= 2
      list_of_possible_forks << num
    end
  end
  list_of_possible_forks
end

def fork_possible?(state, win_conditions, side)
  !possible_forks(state, win_conditions, side).empty?
end

def empty_corners(state)
  empty_corners = []
  [0, 2, 6, 8].each { |corner| empty_corners << corner if state[corner].nil? }
  empty_corners
end

def pick_a_corner(state, opposing_side)
  possible_corners = empty_corners(state)
  good_corners = []
  corner_pairs = [[0, 8], [8, 0], [2, 6], [2, 6]]
  corner_pairs.each do |pair|
    good_corners << pair[0] if pair[0].nil? && pair[1] == opposing_side
  end
  return good_corners.sample unless good_corners.empty?
  possible_corners.sample
end
