# frozen_string_literal: true

require 'knuth'

RSpec.describe Knuth do
  let(:knuth) { described_class.new }

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
    subject { knuth.random }

    it { is_expected.to be >= 0.0 }
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

    it { is_expected.to be >= low }
    it { is_expected.to be <= high }
  end

  describe '#randomize' do
    subject { knuth.randomize }

    before do
      allow(knuth).to receive(:puts).and_return(nil)
      allow(knuth).to receive(:gets).and_return(0.5)
    end

    it { is_expected.to be nil }
  end
end
