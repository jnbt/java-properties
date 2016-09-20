module JavaProperties
  module Encoding
    # Module to encode and decode unicode chars
    # This code is highly influced by Florian Frank's JSON gem
    # @see https://github.com/flori/json/
    module Unicode

      # @private
      MAP = {
        "\x0" => '\u0000',
        "\x1" => '\u0001',
        "\x2" => '\u0002',
        "\x3" => '\u0003',
        "\x4" => '\u0004',
        "\x5" => '\u0005',
        "\x6" => '\u0006',
        "\x7" => '\u0007',
        "\xb" => '\u000b',
        "\xe" => '\u000e',
        "\xf" => '\u000f',
        "\x10" => '\u0010',
        "\x11" => '\u0011',
        "\x12" => '\u0012',
        "\x13" => '\u0013',
        "\x14" => '\u0014',
        "\x15" => '\u0015',
        "\x16" => '\u0016',
        "\x17" => '\u0017',
        "\x18" => '\u0018',
        "\x19" => '\u0019',
        "\x1a" => '\u001a',
        "\x1b" => '\u001b',
        "\x1c" => '\u001c',
        "\x1d" => '\u001d',
        "\x1e" => '\u001e',
        "\x1f" => '\u001f',
      }

      # @private
      EMPTY_8BIT_STRING = ''
      EMPTY_8BIT_STRING.force_encoding(::Encoding::ASCII_8BIT)

      # Decodes all unicode chars from escape sequences in place
      # @param text [String]
      # @return [String] The encoded text for chaining
      def self.decode!(text)
        string = text.dup
        string = string.gsub(%r((?:\\[uU](?:[A-Fa-f\d]{4}))+)) do |c|
          c.downcase!
          bytes = EMPTY_8BIT_STRING.dup
          i = 0
          while c[6 * i] == ?\\ && c[6 * i + 1] == ?u
            bytes << c[6 * i + 2, 2].to_i(16) << c[6 * i + 4, 2].to_i(16)
            i += 1
          end
          bytes.encode("utf-8", "utf-16be")
        end
        string.force_encoding(::Encoding::UTF_8)

        text.replace string
        text
      end

      # Decodes all unicode chars into escape sequences in place
      # @param text [String]
      # @return [String] The decoded text for chaining
      def self.encode!(text)
        string = text.dup
        string.force_encoding(::Encoding::ASCII_8BIT)
        string.gsub!(/["\\\x0-\x1f]/n) { |c| MAP[c] || c }
        string.gsub!(/(
          (?:
           [\xc2-\xdf][\x80-\xbf]    |
           [\xe0-\xef][\x80-\xbf]{2} |
           [\xf0-\xf4][\x80-\xbf]{3}
          )+ |
          [\x80-\xc1\xf5-\xff]       # invalid
        )/nx) { |c|
          c.size == 1 and raise "Invalid utf8 byte: '#{c}'"
          s = c.encode("utf-16be", "utf-8").unpack('H*')[0]
          s.force_encoding(::Encoding::ASCII_8BIT)
          s.gsub!(/.{4}/n, '\\\\u\&')
          s.force_encoding(::Encoding::UTF_8)
        }
        string.force_encoding(::Encoding::UTF_8)
        text.replace string
        text
      end

      private

      def self.unicode(code)
        code.chr(::Encoding::UTF_8)
      end

      def self.hex(codepoint)
        hex  = codepoint.to_s(16)
        size = [4, hex.size].max
        target_size = size.even? ? size : size+1
        hex.rjust(target_size, '0')
      end

    end
  end
end
