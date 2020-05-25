require 'helper'

describe JavaProperties::Encoding::SpecialChars do
  subject{ JavaProperties::Encoding::SpecialChars }
  let(:raw)    { "this\\is some \n text \t wi\\th special\r chars\f" }
  let(:encoded){ 'this\\\\is some \n text \t wi\\\\th special\r chars\f' }

  it "encodes special chars" do
    processed = subject.encode!(raw.dup)
    _(processed).must_equal encoded
  end

  it "decodes special chars" do
    processed = subject.decode!(encoded.dup)
    _(processed).must_equal raw
  end

  it "decodes and encodes to the same" do
    encoded  = subject.encode!(raw.dup)
    deconded = subject.decode!(encoded)
    _(deconded).must_equal raw
  end

  it "handled backslash escpaing" do
    decoded = subject.decode!('some\\\\test\\\\')
    _(decoded).must_equal 'some\\test\\'
    encoded = subject.encode!('some\\test\\')
    _(encoded).must_equal 'some\\\\test\\\\'
  end
end
