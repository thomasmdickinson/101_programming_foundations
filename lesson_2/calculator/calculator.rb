require 'yaml'

# Bonus feature 4 - moves messages to configuration file
# Bonus feature 5 - adds spanish and french
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  # Bonus Feature 1 - validates correctly for 0
  # Bonus Feature 2 - validates correctly for floats
  num == '0' || num.to_i != 0 || num.to_f.to_s == num
end

# Bonus feature 3 - allows for code to be added to the method
def operation_to_message(op)
  message = case op
            when '1'
              'Adding'
            when '2'
              'Subtracting'
            when '3'
              'Multiplying'
            when '4'
              'Dividing'
            end
  message
end

name = ''
operator = ''
number1 = ''
number2 = ''
lang = 'en'

prompt(MESSAGES[lang]['welcome'])

loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt(MESSAGES[lang]['valid_name'])
  else
    break
  end
end

lang_prompt = <<-LNG
  Enter EN for English.
  Introducir ES para español.
  Entrez FR pour les français.
LNG

prompt(lang_prompt)

# Bonus feature 5 - adds spanish and french
loop do
  lang = Kernel.gets().chomp()
  break if %w(en fr es).include?(lang.downcase)
  # binding.pry
  prompt(MESSAGES[lang]['valid_lang'])
end

# binding.pry

prompt("Hi #{name}!")

loop do # main loop
  loop do
    prompt(MESSAGES[lang]['first_num_ask'])
    number1 = Kernel.gets().chomp()
    if valid_number?(number1)
      break
    else
      prompt(MESSAGES[lang]['valid_number'])
    end
  end

  loop do
    prompt(MESSAGES[lang]['second_num_ask'])
    number2 = Kernel.gets().chomp()
    if valid_number?(number2)
      break
    else
      prompt(MESSAGES[lang]['valid_number'])
    end
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG

  prompt(operator_prompt)

  loop do
    operator = Kernel.gets().chomp()
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES[lang]['valid_op'])
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")
  sleep(1)

  result = case operator
           when '1'
             number1.to_i() + number2.to_i()
           when '2'
             number1.to_i() - number2.to_i()
           when '3'
             number1.to_i() * number2.to_i()
           when '4'
             number1.to_f() / number2.to_f()
           end

  prompt("The result is #{result}")

  prompt(MESSAGES[lang]['ask_again'])
  answer = Kernel.gets().chomp()

  break unless answer.downcase().start_with?('y')
end

prompt(MESSAGES[lang]['thanks_bye'])
