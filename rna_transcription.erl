-module(rna_transcription).

-export([to_rna/1]).


tr(Dst, [H|T]) when [H] == "G" -> tr(["C"|Dst], T);
tr(Dst, [H|T]) when [H] == "C" -> tr(["G"|Dst], T);
tr(Dst, [H|T]) when [H] == "T" -> tr(["A"|Dst], T);
tr(Dst, [H|T]) when [H] == "A" -> tr(["U"|Dst], T);
tr(Dst, []) -> Dst.

to_rna(Strand) -> 
    lists:concat(lists:reverse(tr([], Strand))).
