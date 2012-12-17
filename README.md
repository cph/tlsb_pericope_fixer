# TlsbPericopeFixer

A script to fix bible references in the TLSB XML

## Usage

There are multiple errors in the converted XML returned from Manipal:

 1. Some crossreference links to pericopes have incorrect verse IDs. For example, `00003015` in `<a class="bible" href="00003015-00003015" title="Genesis 3:15">3:15</a>` doesn't have a valid book park (0 is not a valid book ID). In this case, the ID should be `01003015`. The Pericope gem can parse the title attribute in that tag and generate the correct book ID.
 
 2. Some note tags have incorrect verse IDs. For example, `n01000003` in `<note start="n01000003" type="sb" end="n01000003" class="note" id="n01000003">` doesn't have a valid chapter part. It's _actually_ for chapter 3, but the 3 got used as a verse number. So, in this case the start attribute should be `n01003001`. We can assume that a descendent of each `note` will be a `.note-id` and we can figure out the right context from there.
 
 3. Some study notes are not linked back to their corresponding verse. For example,
 
    <note start="n01038020" type="sb" end="n01038020" class="note" id="n01038020"><content><p>relations between a man and his daughter-in-law are immoral (<a class="bible" href="00018015-00018015" title="Leviticus 18:15">Lv 18:15</a>).</p></content></note>
 
