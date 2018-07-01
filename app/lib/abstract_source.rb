class AbstractSource
  CHUNK_SIZE = 4096

  def initialize(text_upload, word_processor)
    @path = text_upload.upload_source
    @word_processor = word_processor
    @text_upload = text_upload
  end

  def fetch_data
    raise 'The method not defined'
  end

  def last_chunk_words
    raise 'The method not defined'
  end

  private

  def persist(words)
    Word.import words.map{ |k, v| @text_upload.words.new(w: k, count: v) }  
  end
end