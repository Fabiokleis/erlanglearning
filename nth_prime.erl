-module(nth_prime).

-export([prime/1]).

next_prime(2) -> 2;
next_prime(N) ->
    case [X || X <- lists:seq(2, trunc(math:sqrt(N))), N rem X == 0] of
        [] -> N;
        Q -> {racional, {N, hd(Q)}}
    end.

prime(0, _, Primes) -> lists:foldl(fun(X, S) -> X * S end, 1, Primes) + 1;
prime(N, Acc, Primes) ->
    case next_prime(Acc+1) of
        {racional, _} -> prime(N, Acc+1, Primes);
        P -> prime(N-1, Acc+1, [P|Primes])
    end.

prime(N) when N > 0 ->
    case next_prime(prime(N, 1, [])) of
	{racional, Q} -> {racional, Q};
	P -> {primo, P}
    end.
