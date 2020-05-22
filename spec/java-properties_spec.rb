# coding: utf-8
require 'helper'

describe JavaProperties do
  subject{ JavaProperties }

  it "parses from string" do
    _(subject.parse("item1=item1")).must_equal({:item1 => "item1"})
  end

  it "generates from hash" do
    _(subject.generate({:item1 => "item1"})).must_equal("item1=item1")
  end

  it "loads from file" do
    with_temp_file do |file|
      file << "item1=item1"
      file.flush

      _(subject.load(file.path)).must_equal({:item1 => "item1"})
    end
  end

  it "writes to file" do
    with_temp_file do |file|
      subject.write({:item1 => "item1"}, file.path)

      file.rewind
      _(file.read).must_equal "item1=item1"
    end
  end

  it "loads from data starting with a BOM" do
    properties = subject.load(fixture_path("bom.properties"))
    expected = {
      :pageTitle => "Some ü text",
      :tagOther => "Other"
    }
    _(properties).must_equal(expected)
  end

  private

  def with_temp_file(&block)
    file = Tempfile.new("java-properties")
    block.call(file)
  ensure
    file.close
    file.unlink
  end

end
