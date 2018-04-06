# frozen_string_literal: true

# This module contains several global variable definitions and six code modules:
#
#   advance_random - retrieves a new batch of pseudorandom numbers.
#   warmup_random  - initializes a random number generator.
#   random         - returns a single pesudorandom real valve
#                    between 0.0 and 1.0
#   flip           - returns result of a simulated biased coin toss.
#   rnd            - returns an integer selected uniformly and pseudorandomly
#                    between upper and lower limits.
#   randomize      - queries terminal for user-specified random seed
#                    and initializes random.
#
class Pseudorandom
  def initialize
    @random_number_array = Array.new(56, 0.0)
    @random_number = 0
  end

  # advance_random - retrieves a new batch of pseudorandom numbers.
  # rubocop:disable Metrics/MethodLength
  def advance_random
    (1..24).each do |index|
      new_random = @random_number_array[index] -
                   @random_number_array[index + 31]
      if new_random < 0
        new_random += 1
        @random_number_array[index] = new_random
      end
    end
    (25..55).each do |index|
      new_random = @random_number_array[index] -
                   @random_number_array[index - 24]
      if new_random < 0
        new_random += 1
        @random_number_array[index] = new_random
      end
    end
    nil
  end
  # rubocop:enable Metrics/MethodLength

  # warmup_random - initializes a random number generator.
  # rubocop:disable Metrics/MethodLength
  def warmup_random(random_seed)
    @random_number_array[55] = random_seed
    new_random = 1e-9
    prev_random = random_seed
    (1..54).each do |index|
      random_index = 21 * index % 55
      @random_number_array[random_index] = new_random
      new_random = prev_random - new_random
      new_random += 1 if new_random < 0
      prev_random = @random_number_array[random_index]
    end
    3.times { advance_random }
    @random_number = 0
    nil
  end
  # rubocop:enable Metrics/MethodLength

  # random - returns a single pesudorandom real valve between 0.0 and 1.0
  # Fetch a single random number between 0.0 and 1.0 - Subtractive Method
  # See Knuth, D. (1969), v. 2 for details
  def random
    @random_number += 1
    if @random_number > 55
      @random_number = 1
      advance_random
    end
    @random_number_array[@random_number]
  end

  # flip - returns result of a simulted biased coin toss (true == head).
  def flip(probability)
    probability == 1 ? true : (random < probability)
  end

  # rnd - returns an integer selected uniformly
  # and pseudorandomly between upper and lower limits.
  def rnd(low, high)
    if low >= high
      low
    else
      i = (random * (high - low + 1) + low).truncate
      i > high ? high : i
    end
  end

  # randomize - queries terminal for user-specified random seed
  # and initializes random.
  def randomize
    random_seed = -1
    while random_seed < 0 || random_seed > 1
      puts 'Enter seed random number (0.0..1.0): '
      user_input = gets
      random_seed = user_input.to_i
    end
    warmup_random(random_seed)
  end
end
