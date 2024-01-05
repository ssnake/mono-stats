# frozen_string_literal: true

require_relative 'stats/version'
require_relative 'stats/downloader'
require_relative 'stats/cached_downloader'
require_relative 'stats/analyzer'
require_relative 'stats/report'
require_relative 'stats/sorter'

module Mono
  module Stats
    class Error < StandardError; end
    # Your code goes here...
  end
end
