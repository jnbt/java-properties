module JavaProperties
  module Encoding
    # Module to escape separators as : or =
    module Separators

      # Marker for all separators
      # @return [Regexp]
      ENCODE_SEPARATOR_MARKER = /[ :=]/

      # Marker for already escaped separators
      # @return [Regexp]
      ESCAPING_MARKER  = /\\/

      # Char to use for escaping
      # @return [String]
      ESCAPE           = "\\"

      # Marker for all escaped separators
      # @return [Regexp]
      DECODE_SEPARATOR_MARKER = /\\([ :=])/

      # Escapes all not already escaped separators
      # @param text [text]
      # @return [String]
      def self.encode!(text)
        buffer = StringIO.new
        last_token = ''
        text.each_char do |char|
          if char =~ ENCODE_SEPARATOR_MARKER && last_token !~ ESCAPING_MARKER
            buffer << ESCAPE
          end
          buffer << char
          last_token = char
        end
        text.replace buffer.string
        text
      end

      # Removes escapes from escaped separators
      # @param text [text]
      # @return [String]
      def self.decode!(text)
        text.gsub!(DECODE_SEPARATOR_MARKER) do
          $1
        end
        text
      end

    end
  end
end