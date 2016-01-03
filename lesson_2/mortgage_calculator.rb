# Welcomes the user
Kernel.puts("Welcome to the mortgage payment calculator!")
sleep 1
Kernel.puts("Please tell me your name.")
name = Kernel.gets().chomp()
Kernel.puts("Hi, #{name}. I'll need some information to get started.")
sleep 1

loop do # Main loop
  # Gets the loan amount
  Kernel.puts("First, can you tell me the amount of the loan?")
  loan_amt = Kernel.gets().chomp().to_f
  loop do
    break if loan_amt > 0
    Kernel.puts("Try again... please enter a positive number, with no punctuation (other than the decimal).")
    loan_amt = Kernel.gets().chomp().to_f
  end

  # Gets the APR and converts it to monthly percentage
  Kernel.puts("Okay, next, please tell me the APR, expressed as a decimal.")
  loan_apr = Kernel.gets().chomp().to_f
  loop do
    break if loan_apr > 0 && loan_apr < 1
    Kernel.puts("That's not a valid APR... please enter a number between 0 and 1.")
    loan_apr = Kernel.gets().chomp().to_f
  end
  monthly_interest = loan_apr / 12

  # Gets the loan duration in years and converts it to months
  Kernel.puts("Lastly, tell me the loan duration in whole years.")
  loan_years = Kernel.gets().chomp().to_i
  loop do
    break if loan_years > 0
    Kernel.puts("That's not a valid duration... can you try again?")
    loan_years = Kernel.gets().chomp().to_i
  end
  loan_months = loan_years * 12

  # Just a bit of suspense, for fun
  Kernel.puts("Okay, calculating...")
  sleep(1)
  Kernel.puts(".")
  sleep(1)
  Kernel.puts(".")
  sleep(1)
  Kernel.puts(".")

  # Calculates the fixed payment
  monthly_payment = loan_amt * monthly_interest *
                    ((1 + monthly_interest)**loan_months) /
                    (((1 + monthly_interest)**loan_months) - 1)
  Kernel.puts("#{name}, your monthly payment will be $#{monthly_payment.round(2)}.")

  # Determines whether the loop should continue
  Kernel.puts("If you'd like to calculate another loan? Type Y for yes, N for no.")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

# Says goodbye to the yser
Kernel.puts("Okay, I hope I was helpful. Bye!")
