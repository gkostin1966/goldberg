# frozen_string_literal: true

# A. Use the random number generator given in knuth.rb to create a program
# where you generate 1000 random numbers between 0 and 1. Keep track of how
# many numbers are generated in each of the four quartiles,
# 0-0.25, 0.25-0.5, 0.5-0.75, 0.75-1,
# and compare the actual counts with the expected number.
# Is the difference within reasonable limits?
# How can you quantify whether the difference is reasonable?

require 'pseudorandom'

RSpec.describe Pseudorandom do
  let(:pseudorandom) { described_class.new(seed) }
  let(:seed) { 0.25 }

  describe 'random' do
    it do
      pseudorandom
      1000.times do
        number = pseudorandom.random
        expect(number).to be_between(0, 1)
      end
    end
  end

  describe 'tracker' do
    let(:results) { pseudorandom.track(tries) }
    let(:tries) { 1000 }
    let(:tolerance) { (tries / 4) + (tries * 0.02) }

    it 'sums to 1000' do # rubocop:disable RSpec/MultipleExpectations, RSpec/ExampleLength
      expect(results.tries).to eq(tries)
      expect(results.under).to eq(0)
      expect(results.over).to eq(0)
      expect(results.first + results.second + results.third + results.forth).to eq(tries)
      expect(results.first).to be < tolerance
      expect(results.second).to be < tolerance
      expect(results.third).to be < tolerance
      expect(results.forth).to be < tolerance
    end
  end
end
