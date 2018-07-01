class WordsController < ApplicationController
  def index
  end

  def count
    p params[:payload_type]
    redirect_to :words_index, alert: 'Payload empty' and return unless params[:payload].present?
    redirect_to :words_index, alert: 'Payload type not supported' and return unless TextUpload::PAYLOAD_TYPES[params[:payload_type].to_sym]
    redirect_to :words_index, alert: 'File doesn\'t exist' and return if params[:payload_type] == 'file' && !file_exists
    params[:payload] = FileSource::FOLDER_BASE_PATH + params[:payload] if params[:payload_type] == 'file'
    
    WordCountWorker.perform_async(create_upload.id)
  end

  def upload_list
    @uploads = TextUpload.all
  end

  def stat
    @uploads = TextUpload.all
    @upload = @uploads.find(params[:upload].downcase)
    word_stat = @upload
      .words
      .select(:w)
      .where(w: params[:word])
      .group(:w)
      .sum(:count)

    redirect_to :words_upload_list, alert: 'Word not found. Try a bit later. It could be being processed.' and return if word_stat.empty?

    @word = word_stat.keys.first
    @count = word_stat.values.first

    render 'upload_list'
  end

  private 

  def file_exists
     params[:payload].present? && File.exists?("#{Word::BOOK_FOLDER}/#{params[:payload]}")
  end

  def create_upload
    TextUpload.create(
      h: Digest::SHA1.hexdigest(params[:payload]), 
      source_type: params[:payload_type],
      upload_source: params[:payload]
    )
  end
end
