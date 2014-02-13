module JavaProperties
  module Parsing
    # Module to normalize the content of a properties file
    # 
    # @example Normalizes:
    #   # Comment 1
    #   ! Comment 2
    #   item0
    #   item1 = item1 
    #   item2 : item2 
    #   item3=line 1 \
    #         line 2
    #
    # @example Into:
    #
    #   item0
    #   item1=item1 
    #   item2=item2 
    #   item3=line 1 line 2
    #
    module Normalizer

      # Describes a single normalization rule by replacing content
      class Rule
        # Initializes a new rules base on a matching regexp
        # and a replacement as substitution
        # @param matcher [Regexp]
        # @param replacement [String]
        def initialize(matcher, replacement = '')
          @matcher     = matcher
          @replacement = replacement
        end

        # Apply the substitution to the text in place
        # @param text [string]
        # @return [String]
        def apply!(text)
          text.gsub!(@matcher, @replacement)
        end
      end

      # Collection of ordered rules
      RULES = []

      # Removes comments
      RULES << Rule.new(/^\s*[!\#].*$/)
      
      # Removes leading whitepsace
      RULES << Rule.new(/^\s+/)
      
      # Removes tailing whitepsace
      RULES << Rule.new(/\s+$/)

      # Strings ending with \ are concatenated
      RULES << Rule.new(/\\\s*$[\n\r]+/)

      # Remove whitespace around delimiters and replace with =
      RULES << Rule.new(/^((?:(?:\\[=: \t])|[^=: \t])+)[ \t]*[=: \t][ \t]*/, '\1=')

      RULES.freeze

      # Normalizes the content of a properties file content by applying the RULES
      # @param text [String]
      # @return [String] 
      def self.normalize!(text)
        RULES.each do |rule|
          rule.apply!(text)
        end
        text
      end

    end
  end
end