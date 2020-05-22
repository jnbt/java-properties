require 'helper'

describe JavaProperties::Encoding::Separators do
  subject{ JavaProperties::Encoding::Separators }
  let(:raw)    { 'this is some = text : with special \\=separators' }
  let(:raw_normalizd) { 'this is some = text : with special =separators' }
  let(:encoded){ 'this\\ is\\ some\\ \\=\\ text\\ \\:\\ with\\ special\\ \\=separators' }

  it "encodes separators" do
    processed = subject.encode!(raw.dup)
    _(processed).must_equal encoded
  end

  it "decodes separators" do
    processed = subject.decode!(encoded.dup)
    _(processed).must_equal raw_normalizd
  end

end
