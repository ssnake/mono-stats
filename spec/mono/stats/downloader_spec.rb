# frozen_string_literal: true

RSpec.describe Mono::Stats::Downloader do
  let(:downloader) { described_class.new(api_token: token, account_id: account_id) }

  let(:token) { ENV['MONO_TOKEN'] }
  let(:account_id) { ENV['MONO_ACCOUNT_ID'] }

  describe '#fetch' do
    subject { downloader.fetch(from: from, to: to) }

    let(:from) { DateTime.iso8601('2023-10-01T10:00:00+02:00') }
    let(:to) { DateTime.iso8601('2023-10-01T19:00:00+02:00')}

    it 'fetches the statements', :vcr do
      is_expected.to eq(
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
          }
        ]
      )
    end
  end

end
