-module(nth_prime).

-export([prime/1]).

next_prime(2) -> 2;
next_prime(N) ->
    case [X || X <- lists:seq(2, trunc(math:sqrt(N))), N rem X == 0] of
        [] -> N;
        _ -> []
    end.

prime(0, _, [H|_]) -> H;
prime(N, Acc, Primes) ->
    case next_prime(Acc+1) of
        [] -> prime(N, Acc+1, Primes);
        P -> prime(N-1, Acc+1, [P|Primes])
    end.

prime(N) when N > 0 ->
    prime(N, 1, []).
