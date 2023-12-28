-module(rna_transcription).

-export([to_rna/1]).


tr(Dst, [H|T]) when [H] == "G" -> tr(Dst ++ "C", T);
tr(Dst, [H|T]) when [H] == "C" -> tr(Dst ++ "G", T);
tr(Dst, [H|T]) when [H] == "T" -> tr(Dst ++ "A", T);
tr(Dst, [H|T]) when [H] == "A" -> tr(Dst ++ "U", T);
tr(Dst, []) -> Dst.

to_rna(Strand) -> 
    tr([], Strand).
