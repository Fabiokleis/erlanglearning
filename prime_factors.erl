-module(prime_factors).

-export([factors/1]).

%% idiot version of factors... shauhsu
%% primes_until(1, Ps) -> Ps;
%% primes_until(2, Ps) -> [2|Ps];
%% primes_until(N, Ps) ->
%%     case lists:filter(fun(X) -> lists:all(fun(A) -> X rem A /= 0 end, lists:seq(2, N-1)) end, lists:seq(2, N-1)) of
%%         [] -> primes_until(N-1, [N|Ps]);
%%         V -> primes_until(N-1, [hd(V)|Ps])
%%     end.
%% 
%% 
%% break_into_facts(N) ->
%%     C = lists:filter(fun(X) -> length(lists:filter(fun(A) -> X * A == N end, lists:seq(1, N))) > 0 end, lists:seq(1, N)),
%%     F1 = lists:nth(length(C) div 2, tl(C)),
%%     {F1, N div F1}.
%% 
%% factors(1) -> [];
%% factors(Value) -> 
%%     io:format("~p~n", [break_into_facts(Value)]),
%%     case break_into_facts(Value) of
%%         {V, 1} -> [X || X <- primes_until(V, []), V rem X == 0]; 
%%         {V, N} -> [factors(V)|factors(N)]
%%     end.


%% exercism last iteration
next_prime(2) -> 2;
next_prime(N) ->
    case [X || X <- lists:seq(2, trunc(math:sqrt(N))), N rem X == 0] of
        [] -> N;
        P -> hd(P)
    end.

facts(1, _, Acc) -> Acc;
facts(N, P, Acc) ->
    F = next_prime(P),
    case N rem F of
         0 -> facts(N div F, 2, [F|Acc]);
         _ -> facts(N, P+1, Acc)
    end.

factors(Value) -> 
    facts(Value, 2, []).

