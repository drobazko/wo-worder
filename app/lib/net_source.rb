require 'net/http'

class NetSource < AbstractSource
  def initialize(text_upload, word_processor)
    super
    url = text_upload.upload_source
    @uri = URI.parse(url)
    @https = url.include?('https')
  end

  def fetch_data
    offset = 0
    Net::HTTP.start(@uri.host, @uri.port, use_ssl: @https) do |http|
      request = Net::HTTP::Get.new(@uri.request_uri)

      http.request(request) do |response|
        response.read_body do |chunk|
          words = @word_processor.process!(chunk, offset += chunk.size)
          persist(words)
        end
      end
      persist(@word_processor.last_chunk_words) if @word_processor.last_chunk_words.any?
    end
  end
end