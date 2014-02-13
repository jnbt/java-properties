module JavaProperties
  module Parsing
    module Parser

      KEY_VALUE_MARKER = /^([^=]*)=(.*)$/
      KEY_ONLY_MARKER  = /^(\S+)$/

      def self.parse(text)
        properties = Properties.new
        Normalizer.normalize!(text)
        text.each_line do |line|
          key, value = extract_key_and_value(line)
          append_to_properties(properties, key, value)
        end
        properties
      end

      private 

      def self.extract_key_and_value(line)
        if line =~ KEY_VALUE_MARKER
          [$1, $2]
        elsif line =~ KEY_ONLY_MARKER
          [$1, '']
        else
          [nil, nil]
        end
      end

      def self.append_to_properties(properties, key, value)
        unless key.nil? && value.nil?
          properties[Encoding.decode!(key).to_sym] = Encoding.decode!(value)
        end
      end

    end
  end
end