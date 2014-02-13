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

      # Generates a properties file content based on a hash
      # @param properties [Properties] or simple hash
      # @return [String]
      def self.generate(properties)
        lines = []
        properties.each do |key, value|
          lines << build_line(key, value)
        end
        lines.join("\n")
      end

      private

      def self.build_line(key, value = '')
        Encoding.encode!(key.to_s) +
        KEY_VALUE_SEPARATOR +
        Encoding.encode!(value.to_s, :skip_separators)
      end
    end
  end
end
