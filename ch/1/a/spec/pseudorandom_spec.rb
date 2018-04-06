# frozen_string_literal: true

require 'pseudorandom'

RSpec.describe Pseudorandom do
  let(:pseudorandom) { described_class.new }

  describe '#advance_random' do
    subject { pseudorandom.advance_random }

    it { is_expected.to be nil }
  end

  describe '#warmup_random' do
    subject { pseudorandom.warmup_random(random_seed) }

    let(:random_seed) { 0.5 }

    it { is_expected.to be nil }
  end

  describe '#random' do
    subject { pseudorandom.random }

    it { is_expected.to be >= 0.0 }
  end

  describe '#flip' do
    subject { pseudorandom.flip(probability) }

    let(:probability) { 0.5 }

    it { is_expected.to be(true || false) }
  end

  describe '#rnd' do
    subject { pseudorandom.rnd(low, high) }

    before { pseudorandom.warmup_random(0.5) }

    let(:low) { 0.25 }
    let(:high) { 0.75 }

    it { is_expected.to be >= low }
    it { is_expected.to be <= high }
  end

  describe '#randomize' do
    subject { pseudorandom.randomize }

    before { allow(pseudorandom).to receive(:gets).and_return(0.5) }

    it { is_expected.to be nil }
  end
end
