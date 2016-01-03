#1.
# What would you expect the code below to print out?

  # numbers = [1, 2, 2, 3]
  # numbers.uniq

  # puts numbers

"It would print numbers 1, 2, 2, and 3."
"This is because the uniq method does not mutate the caller."

# 2.
# Describe the difference between ! and ? in Ruby.

"Both of these often appear in method names. ! generally means that the method
mutates the caller. ? generally means that it checks something and returns
true or false. However, these are true only by convention, not an actual part
of the Ruby syntax, and cannot be relied on. ! is also used as a negation, for
instance != is 'not equals' and !p is 'not p' (evaluated as a boolean) true or
false). ? can be used with : to write if/esle statements."

# And explain what would happen in the following scenarios:

  # 1. what is != and where should you use it?
  "Not equals. Should be used in comparison"

  # 2. put ! before something, like !user_name
  "the boolean opposite of user_name. So if user_name evaluates to true,
  !user_name is false, and if user_name evaluates to false, !user_name is true."

  # 3. put ! after something, like words.uniq!
  "In the case of uniq!, it functions like uniq but mutates the caller. However,
  this is only because uniq and uniq! are both existing methods. Just adding a !
  is meaningless and will cause an error, unless a method has been defined with
  ! as part of the name."

  # 4. put ? before something
  "causes an error"

  # 5. put ? after something
  "causes an error"

  # 6. put !! before something, like !!user_name
  "evaluates user_name as a boolean--in other words, the boolean opposite of
  !user_name."

# 3.
# Replace the word "important" with "urgent" in this string:

advice = "Few things in life are as important as house training your pet dinosaur."
advice.sub('important', 'urgent')


# 4.
# The Ruby Array class has several methods for removing items from the array.
# Two of them have very similar names. Let's see how they differ:

  # numbers = [1, 2, 3, 4, 5]

# What does the follow method calls do
# (assume we reset numbers to the original array between method calls)?

  # numbers.delete_at(1)
  # numbers.delete(1)

"The delete_at method deletes the item with the given key. The delete method
deletes the item with the given value. Because the array contains item with a
key of 1 and a value of 2, and it contains an item with a key of 0 and a value
of 1, both method calls work, but they delete different items."

# 5.
# Programmatically determine if 42 lies between 10 and 100.

(10..100).include?(42)

# 6.
# Starting with the string:

  # famous_words = "seven years ago..."

# show two different ways to put the expected "Four score and " in front of it.

famous_words = "seven years ago..."
puts "Four score and #{famous_words}"
puts "Four score and " + famous_words
puts "Four score and " << famous_words

# 7.
# Fun with gsub:

  # def add_eight(number)
  #   number + 8
  # end
  #
  # number = 2
  #
  # how_deep = "number"
  # 5.times { how_deep.gsub!("number", "add_eight(number)") }
  #
  # p how_deep

# This gives us a string that looks like a "recursive" method call:

  # "add_eight(add_eight(add_eight(add_eight(add_eight(number)))))"

# If we take advantage of Ruby's Kernel#eval method to have it
# execute this string as if it were a "recursive" method call

  # eval(how_deep)

# what will be the result?

"this will take the variable number, which is equal to 2, and add 8 5 times,
resulting in:"

42

# 8.
# If we build an array like this:

  flintstones = ["Fred", "Wilma"]
  flintstones << ["Barney", "Betty"]
  flintstones << ["BamBam", "Pebbles"]

# We will end up with this "nested" array:

  # ["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]]

# Make this into an un-nested array.

flintstones.flatten

# 9.
# Given the hash below

  flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

# Turn this into an array containing only two elements:
# Barney's name and Barney's number

flintstones.assoc("Barney")

# 10.
# Given the array below

  flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

# Turn this array into a hash where the names are the keys
# and the values are the positions in the array.

flintstones_hash = {}

flintstones.each_index do |idx|
  flintstones_hash[flintstones[idx]] = idx
end
