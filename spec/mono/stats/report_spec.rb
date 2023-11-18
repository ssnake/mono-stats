# frozen_string_literal: true

require 'fileutils'

RSpec.describe Mono::Stats::Report do
  let(:report) { described_class.new(downloader:, year:) }
  let(:downloader) { instance_double('downloader')}
  let(:year) { 2023 }
  let(:downloaded_result) {
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
        "time"=>1698917544
      }
    ]
    
  }

  before do
    expect(downloader).to receive(:fetch).exactly(12).times.and_return(downloaded_result)
  end
  
  describe '#build_csv' do
    subject { report.build_csv }
    
    it do
      is_expected.to eq(
      <<~EOS.strip
      Paypal;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;7609.56;0.0;0.0
      Кафе;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;4536.0;2136.0;0.0
      EOS
      )
    end
  end

  describe '#export_to_csv' do
    subject { report.export_to_csv(filename: temp_file) }

    let(:temp_file) { 'tmp/test.csv'}
    
    before do
      FileUtils.rm %w(temp_file), force: true
    end

    it do
      subject

      expect(File.read(temp_file)).to eq(
      <<~EOS.strip
      Paypal;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;7609.56;0.0;0.0
      Кафе;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;4536.0;2136.0;0.0
      EOS
      )
    end
  end
end
  