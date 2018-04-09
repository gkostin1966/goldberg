# frozen_string_literal: true

require 'pseudorandom'

RSpec.describe Pseudorandom do
  let(:pseudorandom) { described_class.new }

  it { is_expected.not_to be_nil }
end
