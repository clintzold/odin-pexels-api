class PexelApiService
  include HTTParty

  attr_reader :photos

  def initialize(query)
    @api_key = Rails.application.credentials.dig(:pexels, :api_key)
    @query = query
    @photos = nil
    @base_uri = "https://api.pexels.com/v1/search?query="
  end

  def call
    response = HTTParty.get(@base_uri + @query + "&per_page=10", headers: {"Authorization" => @api_key })
    collect_photos(response.body)
  end

  private

  def collect_photos(response)
    parsed_response = JSON.parse(response)
    collection = []
    parsed_response["photos"].each do |photo|
      collection << {
        src: photo["src"]["medium"],
        photographer: photo["photographer"],
        photographer_url: photo["photographer_url"]
      }
    end
    @photos = collection
  end
end
