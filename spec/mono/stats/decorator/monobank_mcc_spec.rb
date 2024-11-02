# frozen_string_literal: true

RSpec.describe ::Mono::Stats::Decorator::MonobankMcc do
  subject { described_class.new(item:) }
  let(:item) do
    {
      'id' => 'hkRy7QO9jwiZ8L-W',
      'time' => 1_687_262_119,
      'description' => 'Preply',
      'mcc' => 5818,
      'originalMcc' => 5818,
      'amount' => -557_461,
      'operationAmount' => -13_524,
      'currencyCode' => 978,
      'commissionRate' => 0,
      'cashbackAmount' => 0,
      'balance' => 728_891,
      'hold' => false,
      'receiptId' => 'AB6P-9B0T-BKCP-BPHT'
    }
  end
  describe '#category' do
    it 'returns category' do
      expect(subject.category).to eq('Education')
    end
  end
end