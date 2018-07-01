class MemorySource < AbstractSource
  def fetch_data
    words = @word_processor.process!(@text_upload.upload_source, @text_upload.upload_source.size)
    persist(words)
  end
end