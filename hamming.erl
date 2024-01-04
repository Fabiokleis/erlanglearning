-module(hamming).

-export([distance/2]).


count({A, A}, Acc) -> Acc;
count({_, _}, Acc) -> Acc + 1.

distance(Strand1, Strand2) when length(Strand1) /= length(Strand2) ->
    {error, badarg};
distance(Strand1, Strand2) ->
    lists:foldl(fun (X, Acc) -> count(X, Acc) end, 0, lists:zip(Strand1, Strand2)).

