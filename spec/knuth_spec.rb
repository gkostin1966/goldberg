# frozen_string_literal: true

require_relative '../lib/knuth'

RSpec.describe Knuth do
  let(:knuth) { described_class.new }
  let(:debug) { Debug.new }

  describe '#advance_random' do
    subject { knuth.advance_random }

    it { is_expected.to be nil }
  end

  describe '#warmup_random' do
    subject { knuth.warmup_random(random_seed) }

    let(:random_seed) { 0.5 }

    it { is_expected.to be nil }
  end

  describe '#random' do
    subject(:random) { knuth.random }

    it { is_expected.to be_between(0, 1) }

    it 'debug' do
      debug.puts("debug.puts(#{random})")
      expect(random).to be_between(0, 1)
    end
  end

  describe '#flip' do
    subject { knuth.flip(probability) }

    let(:probability) { 0.5 }

    it { is_expected.to be(true || false) }
  end

  describe '#rnd' do
    subject { knuth.rnd(low, high) }

    before { knuth.warmup_random(0.5) }

    let(:low) { 0.25 }
    let(:high) { 0.75 }

    it { is_expected.to be_between(low, high) }
  end

  describe '#randomize' do
    subject { knuth.randomize }

    before do
      allow(knuth).to receive(:puts).and_return(nil)
      allow(knuth).to receive(:gets).and_return(0.5)
    end

    it { is_expected.to be nil }
  end

  describe 'verification' do
    let(:seed) { Random.rand }
    let(:bins) { Array.new(count, 0) }
    let(:count) { 10 }
    let(:epsilon) { 0.02 }
    let(:probability) { 1.0 / count.to_f }
    let(:n) { 1000 }

    it do # rubocop:disable RSpec/ExampleLength
      knuth.warmup_random(seed)
      n.times do
        value = knuth.random
        index = (value / probability).truncate
        bins[index] += 1
      end
      bins.each do |bin|
        p = bin.to_f / n.to_f
        expect(p).to be < probability + epsilon
      end
    end
  end
end
