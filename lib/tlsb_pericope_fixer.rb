require "tlsb/version"
require "tlsb/xml_file"
require "tlsb/pericope_extensions"

module TLSB
  extend self
  
  def parse_reference(reference, options={})
    book_name = options[:book]
    raise ArgumentError("You must say what book this is for") unless book_name
    
    reference = reference.gsub(/^Ch /, "")
    book_and_reference = "#{book_name} #{reference}"
    Pericope.new(book_and_reference)
  end
  
  def format_as_id(pericope)
    raise NotImplementedError("We didn't expect the pericope to have multiple ranges") if pericope.ranges.length > 1
    
    range = pericope.ranges.first
    range.minmax
      .map { |id| "n#{id.to_s.rjust(8, "0")}" }
      .uniq.join("-")
  end
  
end
