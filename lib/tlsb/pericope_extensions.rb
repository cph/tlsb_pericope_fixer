require 'pericope'

module PericopeExtensions
  
  def valid_id?(id)
    id = id.to_i
    book = Pericope.get_book(id)
    chapter = Pericope.get_chapter(id)
    verse = Pericope.get_verse(id)
    
    correct_id = Pericope.get_id(book, chapter, verse)
    id == correct_id
  end
  
end

Pericope.extend PericopeExtensions
