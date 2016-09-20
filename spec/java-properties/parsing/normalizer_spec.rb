require 'helper'

describe JavaProperties::Parsing::Normalizer do
  subject { JavaProperties::Parsing::Normalizer }

  it "normalizes by applying all rules" do
    content    = fixture("test.properties")
    normalized = fixture("test_normalized.properties")
    subject.normalize! content
    content.must_equal normalized
  end

end
