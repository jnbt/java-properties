module JavaProperties
  module Generating
    # This module allows generating the content of a properties file
    # base on a {Properties} object (or any other hash like structure)
    # 
    # @example
    #    Generator.generate({:item => "something ה"}) => "item=something \u05d4"
    #
    module Generator
      # Character used for key-value separation
      # @return [String]
      KEY_VALUE_SEPARATOR = '='

      # Default options
      # @return [Hash]
      DEFAULT_OPTIONS = {
        :skip_encode_unicode       => false,
        :skip_encode_separators    => false,
        :skip_encode_special_chars => false
      }.freeze

      # Generates a properties file content based on a hash
      # @param properties [Properties] or simple hash
      # @param options    [Hash]
      # @option options skip_encode_unicode [Boolean] Skip unicode encoding
      # @option options skip_encode_separators [Boolean] Skip seperators encoding
      # @option options skip_encode_special_chars [Boolean] Skip special char encoding
      # @return [String]
      def self.generate(properties, options = {})
        options = DEFAULT_OPTIONS.merge(options)
        lines = []
        properties.each do |key, value|
          lines << build_line(key, value, options)
        end
        lines.join("\n")
      end

      private

      def self.build_line(key, value, options)
        encoded_key   = Encoding.encode!(key.to_s.dup,   *encoding_skips(false, options))
        encoded_value = Encoding.encode!(value.to_s.dup, *encoding_skips(true,  options))

        encoded_key + KEY_VALUE_SEPARATOR + encoded_value
      end

      def self.encoding_skips(is_value, options)
        skips = []
        skips << Encoding::SKIP_SEPARATORS    if is_value || options[:skip_encode_separators]
        skips << Encoding::SKIP_UNICODE       if options[:skip_encode_unicode]
        skips << Encoding::SKIP_SPECIAL_CHARS if options[:skip_encode_special_chars]
        skips
      end
    end
  end
end
