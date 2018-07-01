class TextUpload < ApplicationRecord
  PAYLOAD_TYPES = {
    net: 'Load by url',
    file: 'Load by file name in ./book folder',
    memory: 'Load by string',
  }

  has_many :words
end
