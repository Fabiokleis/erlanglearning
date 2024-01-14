-module(armstrong_numbers).
-export([is_armstrong_number/1]).

%% first iteration exercism
%% divisor(N, Div, Acc) when Div >= N -> {Div, Acc};
%% divisor(N, Div, Acc) ->
%%     divisor(N, Div*10, Acc+1).
%% 
%% arm_number(_, Div, _, Sum) when Div == 0 -> Sum;
%% arm_number(Number, Div, Power, Sum) when Div > 0 ->
%%     arm_number(Number rem Div, Div div 10, Power, Sum + math:pow(Number div Div, Power)).
%% 
%% is_armstrong_number(Number) ->
%%     {Div, Power} = divisor(Number, 1, 0),
%%     Number == arm_number(Number, Div, Power, 0).    

arm_number(0, _, Sum) -> Sum;
arm_number(Number, Power, Sum) ->
    arm_number(Number div 10, Power, Sum + math:pow(Number rem 10, Power)).

is_armstrong_number(0) -> true;
is_armstrong_number(Number) ->
    Number == arm_number(Number, trunc(math:log10(Number))+1, 0).
