# Board display methods

def display_board(state)
  top_bottom      = '   ----------- '
  row_boundary    = '  |---|---|---|'
  puts '    A   B   C  '
  puts top_bottom
  puts '1 ' + row_string(state, [0, 1, 2])
  puts row_boundary
  puts '2 ' + row_string(state, [3, 4, 5])
  puts row_boundary
  puts '3 ' + row_string(state, [6, 7, 8])
  puts top_bottom
end

def row_string(state, row)
  "|#{cell_string(state[row[0]])}|#{cell_string(state[row[1]])}|\
#{cell_string(state[row[2]])}|"
end

def cell_string(value)
  if value == :x
    ' X '
  elsif value == :o
    ' O '
  else
    '   '
  end
end
