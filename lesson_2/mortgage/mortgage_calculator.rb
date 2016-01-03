require 'yaml'
require 'pry'

MESSAGES = YAML.load_file('mortgage_messages.yml')

def prompt(message)
  Kernel.puts("=> #{message}")
end

# Welcomes the user
prompt(MESSAGES['welcome'])
sleep 1
prompt(MESSAGES['ask_name'])
name = Kernel.gets().chomp()
Kernel.puts("=> Hi, #{name}. I'll need some information to get started.")
sleep 1

loop do # Main loop
  # Gets the loan amount
  prompt(MESSAGES['get_amt'])
  loan_amt = Kernel.gets().chomp().to_f
  loop do
    break if loan_amt > 0
    prompt(MESSAGES['bad_amt'])
    loan_amt = Kernel.gets().chomp().to_f
  end

  # Gets the APR and converts it to monthly percentage
  prompt(MESSAGES['get_apr'])
  loan_apr = Kernel.gets().chomp().to_f
  loop do
    break if loan_apr > 0 && loan_apr < 1
    prompt(MESSAGES['bad_apr'])
    loan_apr = Kernel.gets().chomp().to_f
  end
  monthly_interest = loan_apr / 12

  # Gets the loan duration in years and converts it to months
  prompt(MESSAGES['get_dur'])
  loan_years = Kernel.gets().chomp().to_i
  loop do
    break if loan_years > 0
    prompt(MESSAGES['bad_dur'])
    loan_years = Kernel.gets().chomp().to_i
  end
  loan_months = loan_years * 12

  # Just a bit of suspense, for fun
  prompt(MESSAGES['calc'])
  sleep(1)
  prompt(MESSAGES['suspense'])
  sleep(1)
  prompt(MESSAGES['suspense'])
  sleep(1)
  prompt(MESSAGES['suspense'])

  # Calculates the fixed payment
  monthly_payment = loan_amt * monthly_interest *
                    ((1 + monthly_interest)**loan_months) /
                    (((1 + monthly_interest)**loan_months) - 1)
  Kernel.puts("=> #{name}, your monthly payment will be $#{monthly_payment.round(2)}.")

  # Determines whether the loop should continue
  prompt(MESSAGES['ask_again'])
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

# Says goodbye to the yser
prompt(MESSAGES['bye'])
