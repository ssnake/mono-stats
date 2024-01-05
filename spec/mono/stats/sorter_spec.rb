# frozen_string_literal: true

RSpec.describe Mono::Stats::Sorter do
  subject { described_class.sort(target) }

  let(:target) do
    [[4816, 'Paypal', 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -9609.56, 0.0, 0.0], [5812, 'Кафе', 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -4536.0, -2136.0, 0.0]]
  end

  it do
    is_expected.to(eq [[4816, 'Paypal', 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -9609.56, 0.0, 0.0], [5812, 'Кафе', 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -4536.0, -2136.0, 0.0]])
  end
end
