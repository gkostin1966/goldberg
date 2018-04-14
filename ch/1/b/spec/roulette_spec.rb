# frozen_string_literal: true

# B. Given 10 strings with the following probabilities of selection in the next generation:
# 0.10, 0.20, 0.05, 0.15, 0.00, 0.11, 0.07, 0.04, 0.12, 0.16. Given that these are the only
# possible alternatives, calculate whether the probabilities are consistent. Write a computer
# program that simulates roulette wheel selection of these 10 strings. Spin the wheel 1000 times
# and keep track of the number of selections for each string,
# comparing this number to the expected number of selections.

require 'roulette'

# rubocop:disable RSpec/MultipleExpectations, RSpec/ExampleLength
RSpec.describe Roulette do
  N = 1000

  let(:roulette) { described_class.new(hash_of_strings_and_probabilities) }
  let(:hash_of_strings_and_probabilities) do
    {
      'one' => 0.10,
      'two' => 0.20,
      'three' => 0.05,
      'four' => 0.15,
      'five' => 0.00,
      'six' => 0.11,
      'seven' => 0.07,
      'eight' => 0.04,
      'nine' => 0.12,
      'ten' => 0.16
    }
  end

  it 'consistent' do
    expect(hash_of_strings_and_probabilities.values.reduce(0, :+)).to eq(1.0)
  end

  it '#consistent?' do
    expect(roulette.wheel.consistent?).to be true
    roulette.wheel.slots['one'] = 0.0
    expect(roulette.wheel.consistent?).to be false
    roulette.wheel.normalize
    expect(roulette.wheel.consistent?).to be true
  end

  it 'spins within range' do
    expect(hash_of_strings_and_probabilities.keys.include?(roulette.wheel.spin)).to be true
  end

  it 'after a 1000 spins' do
    expect(roulette.wheel.consistent?).to be true
    tolerance = N.to_f * RouletteWheel::FLOAT_TOLERANCE
    N.times { roulette.spin_wheel }
    expect(roulette.wheel_spins).to eq(N)
    roulette.wheel_history.each do |key, value|
      expect(roulette.wheel.slots[key]).to eq(hash_of_strings_and_probabilities[key])
      ratio = value.to_f / N.to_f
      expect(ratio).to be < (roulette.wheel.slots[key] + tolerance)
      # puts "string #{key} count #{value} ratio #{ratio.truncate(3)} probability #{roulette.wheel.slots[key].truncate(3)}"
    end
  end

  it 'after a 1000 spins when randomized' do
    roulette.wheel.randomize
    expect(roulette.wheel.consistent?).to be true
    tolerance = N.to_f * RouletteWheel::FLOAT_TOLERANCE
    N.times { roulette.spin_wheel }
    expect(roulette.wheel_spins).to eq(N)
    roulette.wheel_history.each do |key, value|
      expect(roulette.wheel.slots[key]).not_to eq(hash_of_strings_and_probabilities[key])
      ratio = value.to_f / N.to_f
      expect(ratio).to be < (roulette.wheel.slots[key] + tolerance)
      # puts "string #{key} count #{value} ratio #{ratio.truncate(3)} probability #{roulette.wheel.slots[key].truncate(3)}"
    end
  end
end
# rubocop:enable RSpec/MultipleExpectations, RSpec/ExampleLength
