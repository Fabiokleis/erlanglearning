-module(collatz_conjecture).

-export([steps/1]).

count_steps(1, Acc) -> Acc;
count_steps(N, Acc) when N rem 2 == 0 -> 
    count_steps(N div 2, Acc+1);
count_steps(N, Acc) when N rem 2 /= 0 ->
    count_steps(N * 3 + 1, Acc+1).

%%count_steps(N, Acc) ->
%%    case N of
%%        1 -> Acc;
%%        A when A rem 2 == 0 -> 
%%            count_steps(N div 2, Acc+1);
%%        A when A rem 2 /= 0 ->
%%            count_steps(N*3 + 1, Acc+1)
%%    end.

steps(N) when N =< 0 -> error(badarg); 
steps(N) -> 
    count_steps(N, 0).


