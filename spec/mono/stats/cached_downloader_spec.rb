# frozen_string_literal: true

RSpec.describe Mono::Stats::CachedDownloader do
  let(:downloader) { described_class.new(pathname: pathname, api_token: token, account_id: account_id) }

  let(:token) { ENV['MONO_TOKEN'] }
  let(:account_id) { ENV['MONO_ACCOUNT_ID'] }
  let(:pathname) { '/tmp/mono-stats/'}

  describe '#fetch' do
    subject { -> { downloader.fetch(from: from, to: to) } }

    let(:from) { DateTime.iso8601('2023-10-01T10:00:00+02:00') }
    let(:to) { DateTime.iso8601('2023-10-01T19:00:00+02:00')}

    before do
      FileUtils::remove_dir(pathname, force: true)
    end
    
    it 'will download only one time', :vcr do
      expect(downloader).to receive(:perform_request).once().and_call_original
        
      subject.call
      subject.call
    end

  end
end