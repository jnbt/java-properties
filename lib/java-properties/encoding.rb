require 'java-properties/encoding/special_chars'
require 'java-properties/encoding/separators'
require 'java-properties/encoding/unicode'

module JavaProperties
  # Module to encode and decode
  module Encoding

    # Flag for skipping separators encodings / decoding
    # @return [Symbol]
    SKIP_SEPARATORS=:skip_separators

    # Flag for skipping separators encodings / decoding
    # @return [Symbol]
    SKIP_UNICODE=:skip_unicode

    # Flag for skipping separators encodings / decoding
    # @return [Symbol]
    SKIP_SPECIAL_CHARS=:skip_special_chars

    # Encode a given text in place
    # @param text [String]
    # @param flags [Symbol] Optional flags to skip encoding steps
    # @return [String]
    def self.encode!(text, *flags)
      SpecialChars.encode!(text)  unless flags.include?(SKIP_SPECIAL_CHARS)
      Separators.encode!(text)    unless flags.include?(SKIP_SEPARATORS)
      Unicode.encode!(text)       unless flags.include?(SKIP_UNICODE)
      text
    end
    
    # Decodes a given text in place
    # @param text [String]
    # @param flags [Symbol] Optional flags to skip decoding steps
    # @return [String]
    def self.decode!(text, *flags)
      Unicode.decode!(text)       unless flags.include?(SKIP_UNICODE)
      Separators.decode!(text)    unless flags.include?(SKIP_SEPARATORS)
      SpecialChars.decode!(text)  unless flags.include?(SKIP_SPECIAL_CHARS)
      text
    end

  end
end