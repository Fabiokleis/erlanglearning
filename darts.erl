-module(darts).

-export([score/2]).

score(X, Y) ->
    D = math:sqrt(math:pow(X - 0, 2) + math:pow(Y - 0, 2)),
    if D =< 1 -> 10;
        D =< 5 -> 5;
        D =< 10 -> 1;
        true -> 0
    end.
