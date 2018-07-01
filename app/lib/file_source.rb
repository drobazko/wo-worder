require 'net/http'

class FileSource < AbstractSource
  FOLDER_BASE_PATH = './books/'

  def fetch_data
    offset = 0
    File.open @path, 'r' do |source|
      until source.eof?
        words = @word_processor.process!(source.read(CHUNK_SIZE), offset += CHUNK_SIZE)
        persist(words)
      end

      persist(@word_processor.last_chunk_words) if @word_processor.last_chunk_words.any?
    end
  end
end