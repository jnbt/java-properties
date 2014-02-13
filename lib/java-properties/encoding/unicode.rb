module JavaProperties
  module Encoding
    # Module to encode and decode unicode chars
    module Unicode
      
      # Marker for encoded unicode chars
      # @return [Regexp]
      UNICODE_MARKER  = /\\[uU]([0-9a-fA-F]{4,5}|10[0-9a-fA-F]{4})/

      # Escape char for unicode chars
      # @return [String]
      UNICODE_ESCAPE = "\\u"

      # Decodes all unicode chars from escape sequences in place
      # @param text [String]
      # @return [String]
      def self.decode!(text)
        text.gsub!(UNICODE_MARKER) do
          unicode($1.hex)
        end
        text
      end

      # Decodes all unicode chars into escape sequences in place
      # @param text [String]
      # @return [String]
      def self.encode!(text)
        buffer = StringIO.new
        text.each_char do |char|
          if char.ascii_only?
            buffer << char
          else
            buffer << UNICODE_ESCAPE
            buffer << hex(char.codepoints.first)
          end
        end
        text.replace buffer.string
        text
      end

      private

      def self.unicode(code)
        [code].pack("U")
      end

      def self.hex(codepoint)
        hex  = codepoint.to_s(16)
        size = hex.size
        # padding the hex value for uneven digest
        if (size % 2) == 1
          "0#{hex}"
        else
          hex
        end
      end

    end
  end
end