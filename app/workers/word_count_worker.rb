class WordCountWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(upload_id)
    upload = TextUpload.find(upload_id)
    "#{upload.source_type.capitalize}Source"
      .constantize
      .new(upload, WordProcessor.new)
      .fetch_data

    upload.update(status: :finished)
  end

end