require 'dotenv'
require_relative "lib/mono/stats"

Dotenv.load

report = Mono::Stats::Report
  .new(
    downloader: Mono::Stats::CachedDownloader
      .new(
        pathname: 'tmp',
        api_token: ENV['MONO_TOKEN'], 
        account_id: ENV['MONO_ACCOUNT_ID']
      ), 
    year: 2023
  )

report.export_to_csv(filename: 'reports/2023.csv')