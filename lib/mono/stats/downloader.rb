# frozen_string_literal: true

require 'net/http'
require 'json'

module Mono
  module Stats
    class Downloader
      def initialize(api_token:, account_id:)
        @api_token = api_token
        @account_id = account_id
      end

      def perform_request(from:, to:)
        uri = URI("https://api.monobank.ua/personal/statement/#{@account_id}/#{from.to_i}/#{to.to_i}")

        Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
          request = Net::HTTP::Get.new(uri)
          request['X-Token'] = @api_token

          http.request(request)
        end
      end

      def fetch(from:, to:)
        response = perform_request(
          from: from.to_time.to_i,
          to: to.to_time.to_i
        )

        JSON.parse(response.body)
      end
    end
  end
end
