# frozen_string_literal: true

RSpec.describe Mono::Stats::Analyzer do
  let(:analyzer) { described_class.new(statements:) }

  describe '#analyze' do
    subject { analyzer.analyze(columns: %w[01 02 06 10 11]) }

    let(:statements) do
      [
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
        },
        {
          'id' => 'hkRy7QO9jwiZ8L-W',
          'time' => 1_687_262_119,
          'description' => 'Preply2',
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
        },
        {
          'amount' => -62_413,
          'balance' => 550_247,
          'cashbackAmount' => 0,
          'commissionRate' => 0,
          'currencyCode' => 980,
          'description' => 'PayPal',
          'hold' => false,
          'id' => 'kNRK97zEu9hrVBTJ_g',
          'mcc' => 4816,
          'operationAmount' => -60_948,
          'originalMcc' => 4816,
          'receiptId' => 'KKMC-2H4K-5X4A-CCX5',
          'time' => 1_696_177_054
        },
        {
          'amount' => -1000,
          'balance' => 550_247,
          'cashbackAmount' => 0,
          'commissionRate' => 0,
          'currencyCode' => 980,
          'description' => 'PayPal',
          'hold' => false,
          'id' => 'kNRK97zEu9hrVBTJ_g',
          'mcc' => 4816,
          'operationAmount' => -60_948,
          'originalMcc' => 4816,
          'receiptId' => 'KKMC-2H4K-5X4A-CCX5',
          'time' => 1_696_177_054
        },
        {
          'amount' => -37_800,
          'balance' => 612_660,
          'cashbackAmount' => 0,
          'commissionRate' => 0,
          'currencyCode' => 980,
          'description' => 'La Fit Bakery',
          'hold' => true,
          'id' => 'TH3kee15g3zU6c_LOA',
          'mcc' => 5812,
          'operationAmount' => -37_800,
          'originalMcc' => 5812,
          'receiptId' => 'TMBE-7B22-8TX4-7EEE',
          'time' => 1_696_157_137
        },
        {
          'amount' => -17_800,
          'balance' => 612_660,
          'cashbackAmount' => 0,
          'commissionRate' => 0,
          'currencyCode' => 980,
          'description' => 'La Fit Bakery',
          'hold' => true,
          'id' => 'TH3kee15g3zU6c_LOA',
          'mcc' => 5812,
          'operationAmount' => -37_800,
          'originalMcc' => 5812,
          'receiptId' => 'TMBE-7B22-8TX4-7EEE',
          'time' => 1_685_884_434
        }

      ]
    end

    it do
      is_expected.to eq({
                          4816 => { 'Paypal' => { '01' => { 'cred' => 0.0, 'deb' => 0.0 }, '02' => { 'cred' => 0.0, 'deb' => 0.0 },
                                                  '06' => { 'cred' => 0.0, 'deb' => 0.0 }, '10' => { 'cred' => -634.13, 'deb' => 0.0 }, '11' => { 'cred' => 0.0, 'deb' => 0.0 } } },
                          5812 => { 'Кафе' => { '01' => { 'cred' => 0.0, 'deb' => 0.0 }, '02' => { 'cred' => 0.0, 'deb' => 0.0 },
                                                '06' => { 'cred' => -178.0, 'deb' => 0.0 }, '10' => { 'cred' => -378.0, 'deb' => 0.0 }, '11' => { 'cred' => 0.0, 'deb' => 0.0 } } },
                          5818 => {
                            'Preply' => { '01' => { 'cred' => 0.0, 'deb' => 0.0 }, '02' => { 'cred' => 0.0, 'deb' => 0.0 },
                                          '06' => { 'cred' => -5574.61, 'deb' => 0.0 }, '10' => { 'cred' => 0.0, 'deb' => 0.0 }, '11' => { 'cred' => 0.0, 'deb' => 0.0 } }, 'Preply2' => { '01' => { 'cred' => 0.0, 'deb' => 0.0 }, '02' => { 'cred' => 0.0, 'deb' => 0.0 }, '06' => { 'cred' => -5574.61, 'deb' => 0.0 }, '10' => { 'cred' => 0.0, 'deb' => 0.0 }, '11' => { 'cred' => 0.0, 'deb' => 0.0 } }
                          }
                        })
    end
  end
end
