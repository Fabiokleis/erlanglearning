 -module(roman_numerals).

-export([roman/1]).
-define(M, 1000).
-define(D, 500).
-define(C, 100).
-define(L, 50).
-define(X, 10).
-define(V, 5).
-define(I, 1).


roman(0, Acc) -> Acc;
roman(N, Acc) when N - ?M >= 0 ->
    roman(N - ?M, ["M"|Acc]);
roman(N, Acc) when ?M - N =< ?C ->
    roman(N - (?M - ?C), ["CM"|Acc]);
roman(N, Acc) when N - ?D >= 0 ->
    roman(N - ?D, ["D"|Acc]);
roman(N, Acc) when ?D - N =< ?C ->
    roman(N - (?D - ?C), ["CD"|Acc]);
roman(N, Acc) when N - ?C >= 0 ->
    roman(N - ?C, ["C"|Acc]);
roman(N, Acc) when ?C - N =< ?X ->
    roman(N - (?C - ?X), ["XC"|Acc]);
roman(N, Acc) when N - ?L >= 0 ->
    roman(N - ?L, ["L"|Acc]);
roman(N, Acc) when ?C - N =< ?L ->
    roman(N - (?C - ?L), ["LC"|Acc]);
roman(N, Acc) when ?L - N =< ?X ->
    roman(N - (?L - ?X), ["XL"|Acc]);
roman(N, Acc) when N - ?X >= 0 ->
    roman(N - ?X, ["X"|Acc]);
roman(N, Acc) when ?X - N =< ?I ->
    roman(N - (?X - ?I), ["IX"|Acc]);
roman(N, Acc) when N - ?V >= 0 ->
    roman(N - ?V, ["V"|Acc]);
roman(N, Acc) when ?V - N =< ?I ->
    roman(N - (?V - ?I), ["IV"|Acc]);
roman(N, Acc) when N - ?I >= 0 ->
    roman(N - ?I, ["I"|Acc]).

roman(Number) ->
    lists:concat(lists:reverse(roman(Number, ""))).
