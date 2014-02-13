# coding: utf-8
require 'helper'

describe JavaProperties::Encoding do
  subject{ JavaProperties::Encoding }

  it "encodes correctly" do
    raw      = "this is some \n text = with ה"
    expected = 'this\ is\ some\ \n\ text\ \=\ with\ \u05d4'
    encoded  = subject.encode!(raw.dup)
    encoded.must_equal expected
  end

  it "decodes correctly" do
    raw      = 'this\ is\ some\ \n\ text\ =\ with\ \u05d4'
    expected = "this is some \n text = with ה"
    decoded  = subject.decode!(raw.dup)
    decoded.must_equal expected
  end
end