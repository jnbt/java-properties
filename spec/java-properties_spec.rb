require 'helper'

describe JavaProperties do
  subject{ JavaProperties }

  it "parses from string" do
    subject.parse("item1=item1").must_equal({:item1 => "item1"})
  end

  it "generates from hash" do
    subject.generate({:item1 => "item1"}).must_equal("item1=item1")
  end

  it "loads from file" do
    with_temp_file do |file|
      file << "item1=item1"
      file.flush

      subject.load(file.path).must_equal({:item1 => "item1"})
    end
  end

  it "writes to file" do
    with_temp_file do |file|      
      subject.write({:item1 => "item1"}, file.path)

      file.rewind
      file.read.must_equal "item1=item1"
    end
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