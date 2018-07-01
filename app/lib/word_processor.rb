class WordProcessor
  SPACE_BAR = ' '
  WORD_SEPARATORS = "\n\r\t"
  PUNCTUATION = "\'\"\.\,\:\;"
  FIRST_SYMB = 0
  LAST_SYMB = -1
  BEFORE_LAST_SYMB = -2
  EMPTY_STR = ''

  def initialize
    @offset = 0
    @prev_chunk_last_word = ''
    @chunk_to_process = ''
  end

  def process!(chunk, offset)
    @offset = offset
    curr_chunk = chunk.gsub(/[#{WORD_SEPARATORS}]/, SPACE_BAR).gsub(/[#{PUNCTUATION}]/, '')

    chunk_without_last_word, curr_chunk_last_word = divide_sentence(curr_chunk, @prev_chunk_last_word)
    processed_chunk = @prev_chunk_last_word + chunk_without_last_word

    @prev_chunk_last_word = curr_chunk_last_word

    count_words(processed_chunk)
  end

  def last_chunk_words
    return {} unless @prev_chunk_last_word.present? 
    count_words(@prev_chunk_last_word)
  end

  private

  def count_words(chunk)
    chunk.split.map(&:downcase).inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
  end

  # returns [ sentence, last_word ]
  def divide_sentence(chunk, prev_chunk_last_word)
    single_word = chunk.split.size == 1

    return [ EMPTY_STR, chunk ] if prev_chunk_last_word.empty? && single_word
    return [ EMPTY_STR, chunk ] if prev_chunk_last_word[LAST_SYMB] == SPACE_BAR && single_word
    return [ chunk, EMPTY_STR ] if prev_chunk_last_word[LAST_SYMB] != SPACE_BAR && chunk[FIRST_SYMB] != SPACE_BAR && single_word
    [
      (chunk[FIRST_SYMB] == SPACE_BAR ? SPACE_BAR : EMPTY_STR) + chunk.split[FIRST_SYMB..BEFORE_LAST_SYMB].join(SPACE_BAR),
      chunk.split.last + (chunk[LAST_SYMB] == SPACE_BAR ? SPACE_BAR : EMPTY_STR)
    ]
  end
end