# coding: utf-8
require 'helper'

describe JavaProperties::Encoding::Unicode do
  subject{ JavaProperties::Encoding::Unicode }

  let(:encoded) { 'this is some \u0024 text \U05D4 with unicode \u00fc a\u00e4b \ud868\udc2f' }
  let(:encoded_normalized) { 'this is some $ text \u05d4 with unicode \u00fc a\u00e4b \ud868\udc2f' }
  let(:decoded) { 'this is some $ text ה with unicode ü aäb 𪀯' }

  it "decodes unicode chars" do
    _(subject.decode!(encoded.dup)).must_equal decoded
  end

  it "encodes unicode chars" do
    _(subject.encode!(decoded.dup)).must_equal encoded_normalized
  end

  it "encodes unicode chars but has 2-based hex size, padded to at least 4" do
    _(subject.encode!("ü")).must_equal '\u00fc'
    _(subject.encode!("ה")).must_equal '\u05d4'
    _(subject.encode!("ᘓ")).must_equal '\u1613'
  end

  it "decodes unicode chars based on 4 hexdigest" do
    _(subject.decode!('a\u00e4b')).must_equal "aäb"
  end

  it "decodes unicode chars over multiple chunks" do
    _(subject.decode!('\ud868\udc2f')).must_equal "𪀯"
  end

  it "decodes and encodes" do
    encoded  = subject.encode!(decoded.dup)
    dec = subject.decode!(encoded.dup)
    _(dec).must_equal decoded
  end
end
