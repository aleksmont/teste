require 'net/http'
require 'net/https'

module IpHelper
  TOKEN = '6b89820d302b80'

  def self.get_info(ip_address)
    begin
      url = URI("https://ipinfo.io/#{ip_address}?token=#{TOKEN}")
      response = Net::HTTP.get_response(url)
      resp = JSON.parse(response.body)
      {
        success: response.code.to_i == 200,
        city: resp["city"],
        state: resp["region"],
        country: resp["country"]
      }
    rescue StandardError => e
      {
        success: false,
        city: nil,
        state: nil,
        country: nil
      }
    end
  end
end