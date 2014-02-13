module JavaProperties
  module Generating
    module Generator

      KEY_VALUE_SEPARATOR = '='

      def self.generate(properties)
        content = StringIO.new
        properties.each do |key, value|
          append_to_content(content, key, value)
        end
        content.string
      end

      private

      def self.append_to_content(content, key, value = '')
        content << Encoding.encode!(key.to_s)
        content << KEY_VALUE_SEPARATOR
        content << Encoding.encode!(value.to_s, true)
        content << "\n"
      end
    end
  end
end
