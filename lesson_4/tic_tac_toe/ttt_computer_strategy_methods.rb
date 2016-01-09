def line_ready_for_win?(state, line, side)
  line_values = state.values_at(*line)
  line_values.count(nil) == 1 && line_values.count(side) == 2
end

def near_wins(state, win_conditions, side)
  near_wins = []
  win_conditions.each do |line|
    near_wins << line if line_ready_for_win?(state, line, side)
  end
  near_wins
end

def possible_forks(state, win_conditions, side)
  list_of_possible_forks = []
  (0..8).each do |num|
    next unless state[num].nil?
    hypothetical_state = state.clone
    hypothetical_state[num] = side
    if near_wins(hypothetical_state, win_conditions, side).size >= 2
      list_of_possible_forks << num
    end
  end
  list_of_possible_forks
end

def fork_possible?(state, win_conditions, side, opposing_side)
  !possible_forks(state, win_conditions, side).empty? ||
    !possible_forks(state, win_conditions, opposing_side).empty?
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

def pick_random_available_cell(state)
  loop do
    choice = (0..8).to_a.sample
    break if cell_empty?(state, choice)
  end
  choice
end

def complete_a_line(state, win_conditions, side, opposing_side)
  line = near_wins(state, win_conditions, side).sample
  line = near_wins(state, win_conditions, opposing_side).sample if line.nil?
  line.each { |cell| return cell if cell_empty?(state, cell) }
end

def win_possible?(state, win_conditions, side, opposing_side)
  wins = []
  wins += near_wins(state, win_conditions, side)
  wins += near_wins(state, win_conditions, opposing_side)
  !wins.empty?
end

def play_fork(state, win_conditions, side, opposing_side)
  fork_space = possible_forks(state, win_conditions, side).sample
  if fork_space.empty?
    fork_space possible_forks(state, win_conditions, opposing_side).sample
  end
  fork_space
end
