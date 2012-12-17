require 'tlsb/pericope_extensions'

module TLSB
  module Fixes
    module NoteIdFixes
      
      def ensure_note_id_existence!(options={})
        book_name = options[:book]
        raise ArgumentError("You must say what book this is for") unless book_name
        
        document.css('note').each do |note|
          next if note.css(".note-id").any?
          
          strong_tag = note.css('content > p > strong').first()
          unless strong_tag
            # puts "!"*80, note, "!"*80
            next
          end
          
          reference = strong_tag.text
          book_and_reference = "#{book_name} #{reference}"
          pericope = Pericope.new(book_and_reference)
          
          id = pericope.to_a.first.to_s.rjust(8, "0")
          strong_tag << "<a class=\"note-id\" href=\"n#{id}\">#{reference}</a>"
        end
      end
      
    end
  end
end
