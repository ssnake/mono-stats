# frozen_string_literal: true

require 'fileutils'

RSpec.describe Mono::Stats::Report do
  let(:report) { described_class.new(downloader:, analyzer:, year:) }
  let(:downloader) { instance_double('downloader') }
  let(:analyzer) { Mono::Stats::Analyzer.new(only_expenses: false) }
  let(:year) { 2023 }
  let(:downloaded_result) do
    [
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
        'time' => 1_698_917_544
      }
    ]
  end

  before do
    expect(report).to receive(:download).and_return(downloaded_result)
  end

  describe '#build_csv' do
    subject { report.build_csv }

    it do
      is_expected.to eq(
        <<~EOS.strip
          ;;01;02;03;04;05;06;07;08;09;10;11;12
          Paypal;PayPal;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;-634.13;0.0;0.0
          Кафе;La Fit Bakery;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;-378.0;-178.0;0.0
        EOS
      )
    end
  end

  describe '#export_to_csv' do
    subject { report.export_to_csv(filename: temp_file) }

    let(:temp_file) { 'tmp/test.csv' }

    before do
      FileUtils.rm %w[temp_file], force: true
    end

    it do
      subject

      expect(File.read(temp_file)).to eq(
        <<~EOS.strip
          ;;01;02;03;04;05;06;07;08;09;10;11;12
          Paypal;PayPal;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;-634.13;0.0;0.0
          Кафе;La Fit Bakery;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;0.0;-378.0;-178.0;0.0
        EOS
      )
    end
  end
end
