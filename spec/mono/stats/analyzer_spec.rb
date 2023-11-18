# frozen_string_literal: true

RSpec.describe Mono::Stats::Analyzer do
  let(:analyzer) { described_class.new(statements: statements) }

  describe '#analyze' do
    subject { analyzer.analyze(columns: ["01", "02", "10", "11"]) }

    let(:statements) {
      [
        {
          "amount"=>-62413,
          "balance"=>550247,
          "cashbackAmount"=>0,
          "commissionRate"=>0,
          "currencyCode"=>980,
          "description"=>"PayPal",
          "hold"=>false,
          "id"=>"kNRK97zEu9hrVBTJ_g",
          "mcc"=>4816,
          "operationAmount"=>-60948,
          "originalMcc"=>4816,
          "receiptId"=>"KKMC-2H4K-5X4A-CCX5",
          "time"=>1696177054
        },
        {
          "amount"=>-1000,
          "balance"=>550247,
          "cashbackAmount"=>0,
          "commissionRate"=>0,
          "currencyCode"=>980,
          "description"=>"PayPal",
          "hold"=>false,
          "id"=>"kNRK97zEu9hrVBTJ_g",
          "mcc"=>4816,
          "operationAmount"=>-60948,
          "originalMcc"=>4816,
          "receiptId"=>"KKMC-2H4K-5X4A-CCX5",
          "time"=>1696177054
        },
        {
          "amount"=>-37800,
          "balance"=>612660,
          "cashbackAmount"=>0,
          "commissionRate"=>0,
          "currencyCode"=>980,
          "description"=>"La Fit Bakery",
          "hold"=>true,
          "id"=>"TH3kee15g3zU6c_LOA",
          "mcc"=>5812,
          "operationAmount"=>-37800,
          "originalMcc"=>5812,
          "receiptId"=>"TMBE-7B22-8TX4-7EEE",
          "time"=>1696157137
        },
        {
          "amount"=>-17800,
          "balance"=>612660,
          "cashbackAmount"=>0,
          "commissionRate"=>0,
          "currencyCode"=>980,
          "description"=>"La Fit Bakery",
          "hold"=>true,
          "id"=>"TH3kee15g3zU6c_LOA",
          "mcc"=>5812,
          "operationAmount"=>-37800,
          "originalMcc"=>5812,
          "receiptId"=>"TMBE-7B22-8TX4-7EEE",
          "time"=>1685884434
        }
      ]
    }

    it do
      is_expected.to eq({
        "Paypal"=> {"01"=>0.0, "02"=>0.0, "10"=>634.13, "11"=>0.0},
        "Кафе" => {"01"=>0.0, "02"=>0.0, "06"=>178.0, "10"=>378.0, "11"=>0.0}
      }) 
    end
  end  
end
  