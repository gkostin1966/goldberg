# frozen_string_literal: true

require_relative '../../../../lib/knuth'

# Chapter 1 / A Gentle Introduction to Genetic Algorithms
# COMPUTER ASSIGNMENTS A. ... pseudorandom numbers. ...

# Pseudorandom
class Pseudorandom
  attr_reader :knuth

  def initialize(seed = Random.rand)
    @knuth = Knuth.new
    @knuth.warmup_random(seed)
  end

  def random
    @knuth.random
  end
end
