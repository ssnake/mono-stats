# frozen_string_literal: true

require 'net/http'
require 'json'
require 'fileutils'

module Mono
  module Stats
    class CachedDownloader < Downloader
      def initialize(pathname:, api_token:, account_id:)
        super(api_token: api_token, account_id: account_id)

        @pathname = pathname

        FileUtils.mkdir_p(pathname)
      end

      def perform_cached_request(from:, to:)
        filename = cached_filename(from:, to:)
        if File.exists?(filename)
          File.read(filename)
        else
          response = perform_request(
            from:,
            to: 
          )
          if response.code != '200'
            puts 'unable to download'
            return nil 
          end

          File.open(filename, 'w') do |f|   
            f.write(response.body)
            response.body
          end
        end

      end
      
      def fetch(from:, to:)
        response = perform_cached_request(
          from: from.to_time.to_i, 
          to: to.to_time.to_i
        )

        JSON.parse(response) unless response.nil?
      end

      def cached_filename(from:, to:)
        File.join(@pathname, "#{@account_id}_#{from}_#{to}.txt")
      end
    end
  end
end
  