require 'simplecov'

SimpleCov.start do
  if ENV['CI']
    require 'simplecov-lcov'

    SimpleCov::Formatter::LcovFormatter.config do |c|
      c.report_with_single_file = true
      c.single_report_path = 'coverage/lcov.info'
    end

    formatter SimpleCov::Formatter::LcovFormatter
  end
end

require 'minitest/autorun'
require 'java-properties'

class Minitest::Spec

  def fixture(*segments)
    File.read(fixture_path(*segments)).strip
  end

  def fixture_path(*segments)
    File.join(File.dirname(__FILE__), "fixtures", *segments)
  end
end
