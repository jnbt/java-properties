# coding: utf-8
module JavaProperties
  module Parsing
    # This module allows parsing of a properties file content string
    # into a {Properties} object
    #
    # @example
    #   Parser.parse("item=something \u05d4") => {:item => "something ה"}
    #
    module Parser

      # Marker for separation between keys and values
      # after normalization
      # @return [Regexp]
      KEY_VALUE_MARKER = /^([^=]*)=(.*)$/

      # Marker for a line which only consists of an key w/o value
      # @return [Regexp]
      KEY_ONLY_MARKER  = /^(\S+)$/

      # Parses a string into a {Properties} object
      # @param text [String]
      # @return [Properties]
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