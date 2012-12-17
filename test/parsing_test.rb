require "test_helper"


class ParsingTest < ActiveSupport::TestCase
  
  
  test "it should be able to parse some sample HTML and find all the tags that match a.bible" do
    file = TLSB::XmlFile.new File.expand_path("./test/data/Leviticus-studynotes.xml")
    
    links = file.document.css("a.bible")
    assert_equal 386, links.length
  end
  
  
  test "it should ensure that every note has a .note-id that links back to its original context" do
    file = TLSB::XmlFile.new File.expand_path("./test/data/Genesis-studynotes.xml")
    assert_equal 35, file.document.css("note").count { |note| note.css(".note-id").empty? }
    file.ensure_note_id_existence!(book: "Genesis")
    
    # note: there's still 1 bad note because it doesn't have a reference part at all
    assert_equal 1, file.document.css("note").count { |note| note.css(".note-id").empty? }
  end
  
  
  test "it should ensure that every .note-id has the right href" do
    file = TLSB::XmlFile.new File.expand_path("./test/data/Genesis-studynotes.xml")
    assert_equal 250, file.document.css(".note-id").count(&method(:where_note_id_has_the_wrong_href))
    file.ensure_note_id_accuracy!(book: "Genesis")
    assert_equal 0, file.document.css(".note-id").count(&method(:where_note_id_has_the_wrong_href))
  end
  
  
  test "it should ensure that every note tag's start and end attributes match its .note-id's href" do
    file = TLSB::XmlFile.new File.expand_path("./test/data/Genesis-studynotes.xml")
    assert_equal 5, file.document.css("note").count(&method(:where_note_does_not_match_note_id))
    file.ensure_note_matches_note_id!(book: "Genesis")
    assert_equal 0, file.document.css("note").count(&method(:where_note_does_not_match_note_id))
  end
  
  
  def where_note_id_has_the_wrong_href(note_id)
    assumed_book = "Genesis"
    pericope = TLSB.parse_reference(note_id.text, book: assumed_book)
    expected_href = TLSB.format_as_id(pericope)
    note_id["href"] != expected_href
  end
  
  def where_note_does_not_match_note_id(note)
    note_start = note["start"]
    note_end = note["end"]
    expected_href = [note_start, note_end].uniq.join("-")
    note_id = note.css('.note-id')[0]
    return false unless note_id
    note_id["href"] != expected_href
  end
  
  
end
