# coding: utf-8
require 'helper'

describe JavaProperties::Encoding do
  subject{ JavaProperties::Encoding }

  describe "full" do
    let(:decoded){ "this is some \n text = with ה" }
    let(:encoded){ 'this\ is\ some\ \n\ text\ \=\ with\ \u05d4' }

    it "encodes correctly" do
      input     = decoded.dup
      processed = subject.encode!(input)
      _(processed).must_equal encoded
    end

    it "decodes correctly" do
      input     = encoded.dup
      processed = subject.decode!(input)
      _(processed).must_equal decoded
    end
  end

  describe "skip_separators" do
    let(:decoded){ "this is some \n text = with ה" }
    let(:encoded){ 'this is some \n text = with \u05d4' }

     it "encodes correctly" do
      input     = decoded.dup
      processed = subject.encode!(input, subject::SKIP_SEPARATORS)
      _(processed).must_equal encoded
    end

    it "decodes correctly" do
      input     = encoded.dup
      processed = subject.decode!(input, subject::SKIP_SEPARATORS)
      _(processed).must_equal decoded
    end
  end

  describe "skip_unicode" do
    it "encodes correctly" do
      input     = "this is some \n text = with ה"
      processed = subject.encode!(input, subject::SKIP_UNICODE)
      expected  = 'this\ is\ some\ \n\ text\ \=\ with\ ה'
      _(processed).must_equal expected
    end

    it "decodes correctly" do
      input     = 'this\ is\ some\ \n\ text\ \=\ with\ \u05d4'
      processed = subject.decode!(input, subject::SKIP_UNICODE)
      expected  = "this is some \n text = with " + '\u05d4'
      _(processed).must_equal expected
    end
  end

  describe "skip_special_chars" do
    it "encodes correctly" do
      input     = "this is some \n text = with ה"
      processed = subject.encode!(input, subject::SKIP_SPECIAL_CHARS)
      expected  = 'this\ is\ some\ ' + "\n" + '\ text\ \=\ with\ \u05d4'
      _(processed).must_equal expected
    end

    it "decodes correctly" do
      input     = 'this\ is\ some\ \n\ text\ \=\ with\ \u05d4'
      processed = subject.decode!(input, subject::SKIP_SPECIAL_CHARS)
      expected  = 'this is some \n text = with ה'
      _(processed).must_equal expected
    end
  end
end
