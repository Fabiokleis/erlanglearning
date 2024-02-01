-module(rational_numbers).

-export([absolute/1, add/2, divide/2, exp/2, mul/2, reduce/1, sub/2]).

absolute({A, B}) -> reduce({abs(A), abs(B)}).

add({A1, B1}, {A2, B2}) ->
    reduce({A1 * B2 + A2 * B1, B1 * B2}).

divide({A1, B1}, {A2, B2}) when A2 /= 0 ->
    reduce({A1 * B2, B1 * A2}).

exp({A, B}, Exponent) when Exponent < 0 ->
    M = abs(Exponent),
    reduce({math:pow(B, M), math:pow(A, M)});
exp({A, B}, Exponent) -> 
    reduce({math:pow(A, Exponent), math:pow(B, Exponent)});
exp(X, {A, B}) ->
    math:pow(X, A / B).


mul({A1, B1}, {A2, B2}) -> 
    reduce({A1 * A2, B1 * B2}).

standard({A, B}) when A < 0 andalso B < 0 -> {abs(A), abs(B)};
standard({A, B}) when B < 0 -> {-A, abs(B)};
standard(R) -> R.

next_prime(2) -> 2;
next_prime(N) ->
    case [X || X <- lists:seq(2, trunc(math:sqrt(N))), N rem X == 0] of
        [] -> N;
        P -> hd(P)
    end.

reduce({1, B}, _) -> {1, B};
reduce({A, 1}, _) -> {A, 1};
reduce({A, B}, P) when P > abs(A) orelse P > abs(B) -> {A, B};
reduce({A, B}, P) ->
    Factor = next_prime(P),
    case trunc(A) rem Factor == 0 andalso trunc(B) rem Factor == 0 of
        true -> reduce({A / Factor, B / Factor}, P);
        false -> reduce({A, B}, P+1)
    end.

reduce({0, _}) -> {0, 1};
reduce(R) ->
    {A, B} = standard(reduce(R, 2)),
    {trunc(A), trunc(B)}.
    
sub({A1, B1}, {A2, B2}) -> 
    reduce({A1 * B2 - A2 * B1, B1 * B2}).
