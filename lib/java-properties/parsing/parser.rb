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

      # Symbol which separates key from value after normalization
      # @return [String]
      KEY_VALUE_MARKER = '='
      
      # Symbol which escapes a KEY_VALUE_MARKER in the key name
      # @return [String]
      KEY_ESCAPE = '\\'

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
          key, value = extract_key_and_value(line.chomp)
          append_to_properties(properties, key, value)
        end
        properties
      end

      private 

      def self.extract_key_and_value(line)
        # A line must be handled char by char to handled escaped '=' chars in the key name
        key          = StringIO.new
        value        = StringIO.new
        key_complete = false
        last_token   = ''
        line.each_char do |char|
          if !key_complete && char == KEY_VALUE_MARKER && last_token != KEY_ESCAPE
            key_complete = true
          else
            (key_complete ? value : key) << char
          end
          last_token = char
        end
        [key.string, value.string]
      end

      def self.append_to_properties(properties, key, value)
        unless key.nil? && value.nil?
          properties[Encoding.decode!(key).to_sym] = Encoding.decode!(value, Encoding::SKIP_SEPARATORS)
        end
      end

    end
  end
end