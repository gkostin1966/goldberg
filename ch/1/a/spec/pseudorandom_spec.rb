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
  let(:seed) { Random.rand }
  let(:debug) { Debug.new }

  describe 'random' do
    it "returns a number >= 0.0 and <= 1.0" do
      pseudorandom
      1000.times do
        number = pseudorandom.random
        expect(number).to be_between(0, 1)
      end
    end
  end

  describe 'quartiles' do
    let(:min) { 0.25 - epsilon }
    let(:max) { 0.25 + epsilon }
    let(:epsilon) { 0.03 }
    let(:n) { 1000 }
    let(:quartiles) { [0, 0, 0, 0] }

    2.times do |t|
      it "test ##{t}" do
        n.times do
          value = pseudorandom.random
          if value < 0.25
            quartiles[0] += 1
          elsif value < 0.5
            quartiles[1] += 1
          elsif value < 0.75
            quartiles[2] += 1
          else
            quartiles[3] += 1
         end
        end
        quartiles.map! { |v| v / n.to_f }
        4.times do |i|
          debug.puts "quartile #{i}  #{min} > #{quartiles[i]} < #{max}"
          expect(quartiles[i]).to be_between(min, max)
        end
        debug.puts "quartiles sum #{quartiles.sum}"
        expect(quartiles.sum).to be_between(0.0, 1.0)
      end
    end
  end
end
