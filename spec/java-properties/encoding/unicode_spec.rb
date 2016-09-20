# coding: utf-8
require 'helper'

describe JavaProperties::Encoding::Unicode do
  subject{ JavaProperties::Encoding::Unicode }

  let(:encoded) { 'this is some \u0024 text \U05D4 with unicode \u00fc a\u00e4b' }
  let(:encoded_normalized) { 'this is some $ text \u05d4 with unicode \u00fc a\u00e4b' }
  let(:decoded) { 'this is some $ text ה with unicode ü aäb' }

  it "decodes unicode chars" do
    subject.decode!(encoded.dup).must_equal decoded
  end

  it "encodes unicode chars" do
    subject.encode!(decoded.dup).must_equal encoded_normalized
  end

  it "encodes unicode chars but has 2-based hex size, padded to at least 4" do
    subject.encode!("ü").must_equal '\u00fc'
    subject.encode!("ה").must_equal '\u05d4'
    subject.encode!("ᘓ").must_equal '\u1613'
  end

  it "decodes and encodes" do
    encoded  = subject.encode!(decoded.dup)
    dec = subject.decode!(encoded.dup)
    dec.must_equal decoded
  end
end
