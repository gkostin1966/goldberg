# frozen_string_literal: true

require_relative '../../../../lib/knuth'

# Chapter 1 / A Gentle Introduction to Genetic Algorithms
# COMPUTER ASSIGNMENTS A. ... pseudorandom numbers. ...

# Quartiles
class Quartiles
  attr_reader :tries
  attr_reader :under
  attr_reader :first
  attr_reader :second
  attr_reader :third
  attr_reader :forth
  attr_reader :over

  def initialize
    @tries = 0
    @under = 0
    @first = 0
    @second = 0
    @third = 0
    @forth = 0
    @over = 0
  end

  def add(value) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    @tries += 1
    if value < 0
      @under += 1
    elsif value < 0.25
      @first += 1
    elsif value < 0.50
      @second += 1
    elsif value < 0.75
      @third += 1
    elsif value <= 1
      @forth += 1
    else
      @over += 1
    end
  end
end

# Pseudorandom
class Pseudorandom
  attr_reader :knuth

  def initialize(seed)
    @knuth = Knuth.new
    @knuth.warmup_random(seed)
  end

  def random
    @knuth.random
  end

  def track(tries)
    results = Quartiles.new

    tries.times do
      results.add(Random.rand)
    end

    results
  end
end
