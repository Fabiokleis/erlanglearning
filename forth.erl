-module(forth).

-export([evaluate/1]).

%% arit
add(Stack) ->
    [lists:sum(Stack)].

sub(Stack) ->
    [lists:foldl(fun(X, S) -> X - S end, 0, Stack)].

mul(Stack) ->
    [lists:foldl(fun(X, S) -> X * S end, 1, Stack)].

divi(Stack) ->
    [lists:foldl(fun(X, S) -> X div S end, 1, Stack)].

%% stack

dup([H|_] = Stack) -> [H|Stack].

drop([_|T]) -> T.

swap(Stack) when length(Stack) == 2 -> Stack;
swap([H|T]) -> lists:reverse([hd(T)|[H|tl(T)]]).

over([_|T] = Stack) when length(Stack) == 2 -> [hd(T)|Stack];
over([_|T] = Stack) -> lists:reverse([hd(T)|Stack]).
    
push_arg(W) ->
    case catch list_to_integer(W) of
        {'EXIT', _} -> {error, badarg};
	Arg -> {arg, Arg}
    end.

stack_ins("+") -> add;
stack_ins("-") -> sub;
stack_ins("*") -> mul;
stack_ins("/") -> divi;
stack_ins(W) ->
    case string:lowercase(W) of
	"dup" -> dup;
	"drop" -> drop;
	"swap" -> swap;
	"over" -> over;
	_ -> unknown_instruction
    end.
    
evaluate([], Stack) -> Stack;
evaluate([":"|T], [] = Stack) -> undefined;
evaluate([H|T], [] = Stack) ->
    io:format("instruction: ~p~nstack: ~p~n", [H, Stack]),
    case push_arg(H) of
	{arg, Arg} -> evaluate(T, [Arg|Stack]);
	{error, badarg} -> {error, empty_stack}
    end;
evaluate([H|T], Stack) when length(Stack) >= 1 -> 
    io:format("instruction: ~p~nstack: ~p~n", [H, Stack]),
    case push_arg(H) of
	{arg, Arg} -> evaluate(T, [Arg|Stack]);
	{error, badarg} -> 
	    case stack_ins(H) of
		add -> evaluate(T, add(Stack));
		sub -> evaluate(T, sub(Stack));
		mul -> evaluate(T, mul(Stack));
		dup -> evaluate(T, dup(Stack));
		drop -> evaluate(T, drop(Stack));
		divi -> if hd(Stack) =:= 0 -> {error, zero_division};
			   true -> evaluate(T, [divi(Stack)]) end;
		swap -> if length(Stack) < 2 -> {error, not_enough_args};
			   true -> evaluate(T, swap(Stack)) end;
		over -> if length(Stack) < 2 -> {error, not_enough_args};
			   true -> evaluate(T, over(Stack)) end;
		unknown_instruction -> {error, bad_instruction}
	    end
    end.
    
evaluate(Instructions) -> 
    evaluate(string:lexemes(hd(Instructions), " "), []).    
