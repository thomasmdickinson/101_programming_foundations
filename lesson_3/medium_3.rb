# 1.
# Let's do some "ASCII Art" (a stone-age form of nerd artwork from back in the
# days before computers had video screens).

# For this exercise, write a one-line program that creates the following output
# 10 times, with the subsequent line indented 1 space to the right:

  # The Flintstones Rock!
  #  The Flintstones Rock!
  #   The Flintstones Rock!

10.times { |rock| puts "#{"  " * rock} The Flintstones Rock!" }

# 2.
# Create a hash that expresses the frequency
# with which each letter occurs in this string:

  statement = "The Flintstones Rock"

# ex:

  # { "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }

all_letters = statement.gsub(/\s+/, '').split('')
freq_hash = {}

all_letters.uniq.each { |letter| freq_hash[letter] = all_letters.count(letter) }

# 3.
# The result of the following statement will be an error:

  # puts "the value of 40 + 2 is " + (40 + 2)

# Why is this and what are two possible ways to fix this?

"The error indicates that there has been no conversion of fixnum (integer) to
string. Ruby doesn't know how to add a string to an integer."

puts "the value of 40 + 2 is " + (40 + 2).to_s
puts "the value of 40 + 2 is #{(40 + 2)}"

# 4.
# What happens when we modify an array while we are iterating over it?

"The modifications to the array happen in 'real time' as the array is being
iterated through. This means that as the code is executed, the placement of
objects in the array may shift. Ruby doesn't know what object you want the code
to operate on, so it will jsut go to the next spot in the array. If the thing
you want to operate on has moved as a result of the code, it won't work."

# What would be output by this code?

  # numbers = [1, 2, 3, 4]
  # numbers.each do |number|
  #   p number
  #   numbers.shift(1)
  # end

[3, 4]

# What would be output by this code?

  numbers = [1, 2, 3, 4]
  numbers.each do |number|
    p number
    numbers.pop(1)
  end

[1, 2]

# 5.
# Alan wrote the following method, which was intended to show
# all of the factors of the input number:

  # def factors(number)
  #   dividend = number
  #   divisors = []
  #   begin
  #     divisors << number / dividend if number % dividend == 0
  #     dividend -= 1
  #   end until dividend == 0
  #   divisors
  # end

# Alyssa noticed that this will fail if you call this with an input of 0 or a
# negative number and asked Alan to change the loop. How can you change the
# loop construct (instead of using begin/end/until) to make this work?
# Note that we're not looking to find the factors for 0 or negative numbers,
# but we just want to handle it gracefully instead of raising an exception
# or going into an infinite loop.

def factors(number)
  dividend = number
  divisors = []
  while dividend > 0
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors
end

# Bonus 1
# What is the purpose of the number % dividend == 0 ?

"Checks to see if the number has remainder zero and is therefore an integer."

# Bonus 2
# What is the purpose of the second-to-last line in the method
# (the divisors before the method's end)?

"Ensures that the method returns the array with the divisors, rather than nil."

# 6.
# Alyssa was asked to write an implementation of a rolling buffer. Elements
# are added to the rolling buffer and if the buffer becomes full, then new
# elements that are added will displace the oldest elements in the buffer.

# She wrote two implementations saying, "Take your pick. Do you like << or +
# for modifying the buffer?". Is there a difference between the two,
# other than what operator she chose to use to add an element to the buffer?

  # def rolling_buffer1(buffer, max_buffer_size, new_element)
  #   buffer << new_element
  #   buffer.shift if buffer.size >= max_buffer_size
  #   buffer
  # end
  #
  # def rolling_buffer2(input_array, max_buffer_size, new_element)
  #   buffer = input_array + [new_element]
  #   buffer.shift if buffer.size >= max_buffer_size
  #   buffer
  # end

"The difference is that because << mutates the caller, the rolling_buffer1
method will be destructive, changing the buffer argument. rolling_buffer2 does
not touch the input_array argument. Both methods will return the new array.
Which one is prefereable depends whether Alyssa wants to mutate the caller."

# 7.

# Alyssa asked Ben to write up a basic implementation of a Fibonacci calculator,
# A user passes in two numbers, and the calculator will keep computing the
# sequence until some limit is reached. Ben coded up this implementation but
# complained that as soon as he ran it, he got an error.
# Something about the limit variable. What's wrong with the code?

  # limit = 15
  #
  # def fib(first_num, second_num)
  #   while second_num < limit
  #     sum = first_num + second_num
  #     first_num = second_num
  #     second_num = sum
  #   end
  #   sum
  # end
  #
  # result = fib(0, 1)
  # puts "result is #{result}"

"limit is scoped outside the method. Methods can't use variables defined in the
outer scope."

# How would you fix this so that it works?

def fib(first_num, second_num, limit)
  while second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, 15)
puts "result is #{result}"


# 8.
# In another example we used some built-in string methods to change the case of
# a string. A notably missing method is something provided in Rails, but not in
# Ruby itself...titleize! This method in Ruby on Rails creates a string that
# has each word capitalized as it would be in a title.

# Write your own version of the rails titleize implementation.

ap_style = %w(a for so an in the and nor to at of up but on yet by or)

def titlesize(title_input, style)
  title_input.split.each{|word| word.capitalize! unless style.include?(word.downcase)}
end

titlesize("the hitchhiker's guide to the galaxy", ap_style)


# 9.
# Given the munsters hash below

  munsters = {
    "Herman" => { "age" => 32, "gender" => "male" },
    "Lily" => { "age" => 30, "gender" => "female" },
    "Grandpa" => { "age" => 402, "gender" => "male" },
    "Eddie" => { "age" => 10, "gender" => "male" },
    "Marilyn" => { "age" => 23, "gender" => "female"}
  }

# Modify the hash such that each member of the Munster family has an additional
# "age_group" key that has one of three values describing the age group the
# family member is in (kid, adult, or senior).
# Your solution should produce the hash below

# { "Herman" => { "age" => 32, "gender" => "male", "age_group" => "adult" },
#   "Lily" => {"age" => 30, "gender" => "female", "age_group" => "adult" },
#   "Grandpa" => { "age" => 402, "gender" => "male", "age_group" => "senior" },
#   "Eddie" => { "age" => 10, "gender" => "male", "age_group" => "kid" },
#   "Marilyn" => { "age" => 23, "gender" => "female", "age_group" => "adult" } }

# Note: a kid is in the age range 0 - 17, an adult is in the range 18 - 64
# and a senior is aged 65+.

munsters.each do |person, info|
  case info['age']
  when 0..17
    info['age group'] = 'kid'
  when 18..64
    info['age group'] = 'adult'
  else
    info['age group'] = 'senior'
  end
end
