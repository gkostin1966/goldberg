# frozen_string_literal: true

# Chapter 1 / A Gentle Introduction to Genetic Algorithms
# COMPUTER ASSIGNMENTS B. ... roulette ...

# RouletteWheel
class RouletteWheel
  FLOAT_TOLERANCE = 0.01

  attr_accessor :slots

  def initialize(hash_of_strings_and_probabilities)
    @slots = Hash.new(0)
    hash_of_strings_and_probabilities.each do |string, probability|
      @slots[string] = probability
    end
  end

  def randomize
    new_slots = Hash.new(0)
    slots.each { |string| new_slots[string] = Random.rand }
    @slots = new_slots
    normalize
  end

  def normalize
    factor = slots.values.reduce(0, :+)
    slots.each { |string, probability| slots[string] = probability / factor }
  end

  def consistent?
    (1.0 - slots.values.reduce(0, :+)) < FLOAT_TOLERANCE
  end

  def spin
    value = Random.rand
    upper_bound = 0
    slots.each do |string, probability|
      upper_bound += probability
      return string if value <= upper_bound
    end
    nil
  end
end

# Roulette
class Roulette
  attr_accessor :wheel
  attr_accessor :wheel_spins
  attr_accessor :wheel_history

  def initialize(hash_of_strings_and_probabilities)
    @wheel = RouletteWheel.new(hash_of_strings_and_probabilities)
    @wheel_spins = 0
    @wheel_history = Hash.new(0)
  end

  def spin_wheel
    spin_value = wheel.spin
    @wheel_spins += 1
    @wheel_history[spin_value] += 1
    spin_value
  end
end
