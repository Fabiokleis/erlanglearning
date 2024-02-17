-module(forth).

-export([evaluate/1]).

%% arit
add(Stack) -> [lists:sum(Stack)].
sub(Stack) -> [lists:foldl(fun(X, S) -> X - S end, 0, Stack)].
mul(Stack) -> [lists:foldl(fun(X, S) -> X * S end, 1, Stack)].
divi(Stack) -> [lists:foldl(fun(X, S) -> X div S end, 1, Stack)].

%% stack
dup([H|_] = Stack) -> [H|Stack].
drop([_|T]) -> T.
swap(Stack) when length(Stack) == 2 -> lists:reverse(Stack);
swap([H|T]) -> [hd(T)|[H|tl(T)]].
over([_|T] = Stack) when length(Stack) == 2 -> [hd(T)|Stack];
over([_|T] = Stack) -> [hd(T)|Stack].    

%% lexer
stack_ins("+") -> add;
stack_ins("-") -> sub;
stack_ins("*") -> mul;
stack_ins("/") -> divi;
stack_ins(":") -> ins;
stack_ins(W) ->
    case catch list_to_integer(W) of
        {'EXIT', _} -> 
	    case string:lowercase(W) of
		"dup" -> dup;
		"drop" -> drop;
		"swap" -> swap;
		"over" -> over;
		Ins -> {unknown_instruction, Ins}
	    end;
	Int -> {lit, Int}
    end.

lookup_table(Name, Table) -> lists:filter(fun({N, _}) -> N == Name end, Table).

lexer([], Stack, Table) -> {Stack, Table};
lexer([H|T], Stack, Table) ->
    %%io:format("head: ~p~nstack: ~p~ntable: ~p~n~n", [H, Stack, Table]),
    case stack_ins(H) of
	{lit, Int} -> lexer(T, [Int|Stack], Table);
	{unknown_instruction, Ins} -> 
	    case lookup_table(Ins, Table) of
		[] -> error(undefined_instruction);
		[{_, Values}] -> lexer(T, Values ++ Stack, Table)
	    end;
	ins -> 
	    Nins = lists:takewhile(fun(C) -> C =/= ";" end, T), %% simply read until ;
	    InstName = string:lowercase(hd(Nins)),
	    case stack_ins(InstName) of
		{lit, _} -> error(invalid_redefinition); %% only support redefine to string
		_ -> 
		    case lookup_table(InstName, Table) of
			[] -> 
			    {Values, _} = lexer(tl(Nins), Stack, Table),
			    lexer(lists:nthtail(length(Nins) + 1, T), Stack, [{InstName, Values}|Table]);
			[{Name, Values}] -> 
			    {StackValues, _} = lexer(tl(Nins), Stack, Table),
			    lexer(
			      lists:nthtail(length(Nins) + 1, T), Stack,
			      [{InstName, StackValues}|lists:delete({Name, Values}, Table)]
			     )
		    end
	    end;
	_ -> 
	    case lookup_table(H, Table) of
		[] -> lexer(T, [H|Stack], Table);
		[{_, Values}] -> lexer(T, Values ++ Stack, Table)
	    end
    end.

%% evaluator
eval([], Evaluated) -> lists:reverse(Evaluated);
eval([H|T], Evaluated) when is_integer(H) -> eval(T, [H|Evaluated]);
eval([H|T], Evaluated) ->
    case stack_ins(H) of
	add when length(Evaluated) > 1 -> eval(T, add(Evaluated));
	sub when length(Evaluated) > 1 -> eval(T, sub(Evaluated));
	mul when length(Evaluated) > 1 -> eval(T, mul(Evaluated));
	divi when length(Evaluated) > 1 -> eval(T, divi(Evaluated));
	dup when length(Evaluated) > 0 -> eval(T, dup(Evaluated));
	drop when length(Evaluated) > 0 -> eval(T, drop(Evaluated));
	swap when length(Evaluated) > 1 -> eval(T, swap(Evaluated));
	over when length(Evaluated) > 1 -> eval(T, over(Evaluated))
    end.

evaluate(Instructions) -> 
    {S, T} = lists:foldl(
      fun(Ins, {Stack, Table}) -> 
	      lexer(string:lexemes(Ins, " "), Stack, Table)
      end, {[], []}, Instructions),
    io:format("stack: ~p~ntable: ~p~n", [S, T]),
    case catch eval(lists:reverse(S), []) of
	{'EXIT', _} -> error(not_enough_arguments);
	Evaluated -> Evaluated
    end.
