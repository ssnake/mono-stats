# frozen_string_literal: true

require 'dotenv'
require_relative 'lib/mono/stats'

Dotenv.load

report = Mono::Stats::Report
         .new(
           downloader: Mono::Stats::CachedDownloader
             .new(
               pathname: 'tmp',
               api_token: ENV['MONO_TOKEN'],
               account_id: ENV['MONO_ACCOUNT_ID'],
               cooldown: 61
             ),
           analyzer: Mono::Stats::Analyzer
            .new(only_expenses: true),
           year: 2024
         )

report.export_to_csv(filename: 'reports/2024.csv')
