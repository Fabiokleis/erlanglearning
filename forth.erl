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

lookup_table(Name, Table) ->
    lists:filter(fun({N, _}) -> N == Name end, Table).

lexer([], Stack, Table) -> {lists:reverse(Stack), Table};
lexer([H|T], Stack, Table) ->
    %%io:format("instruction: ~p~nstack: ~p~ntable: ~p~n", [H, Stack, Table]),
    case stack_ins(H) of
	{lit, Int} -> lexer(T, [{lit, Int}|Stack], Table);
	{unknown_instruction, Ins} -> 
	    case lookup_table(Ins, Table) of
		[] -> error(undefined_instruction);
		[{Name, _}] -> lexer(T, [{def, Name}|Stack], Table)
	    end;
	ins -> 
	    Nins = lists:takewhile(fun(C) -> C =/= ";" end, T), %% simply read until ;
	    case lookup_table(hd(Nins), Table) of
		[] -> 
		    {Values, _} = lexer(tl(Nins), [], Table),
		    lexer(lists:nthtail(length(Nins) + 1, T), Stack, [{hd(Nins), Values}|Table]);
		[{Name, Values}] -> 
		    %% pls support recursion
		    if hd(tl(Nins)) == hd(Nins) -> todo;
		       true ->
			    {TValues, _} = lexer(tl(Nins), [], Table),
			    lexer(lists:nthtail(length(Nins) + 1, T), Stack, [{hd(Nins), TValues}|lists:delete({Name, Values}, Table)])
		    end
	    end;

	_ -> lexer(T, [{ins, H}|Stack], Table)
    end.

%% evaluator
eval([], _, Evaluated) -> Evaluated;
eval([H|T], Table, Evaluated) ->
    %%io:format("stack: ~p~nevaluated: ~p~n", [H, Evaluated]),
    case H of
	{lit, Num} -> eval(T, Table, [Num|Evaluated]);
	{ins, Name} -> 
	    case stack_ins(Name) of
		add -> eval(T, Table, add(Evaluated));
		sub -> eval(T, Table, sub(Evaluated));
		mul -> eval(T, Table, mul(Evaluated));
		divi -> eval(T, Table, divi(Evaluated));
		dup -> eval(T, Table, dup(Evaluated));
		drop -> eval(T, Table, drop(Evaluated));
		swap -> eval(T, Table, swap(Evaluated));
		over -> eval(T, Table, over(Evaluated))
	    end;
	{def, Name} -> 
	    case lookup_table(Name, Table) of
		[] -> error(undefined_instruction);
		[{_, Values}] -> eval(Values ++ T, Table, Evaluated)
	    end;
	_ -> error(wtf)
    end.

evaluate(Instructions) -> 
    {S, T} = lists:foldl(
      fun(Ins, {Stack, Table}) -> 
	      lexer(string:lexemes(Ins, " "), Stack, Table)
      end, {[], []}, Instructions),
    io:format("stack: ~p~ntable: ~p~n", [S, T]),
    eval(S, T, []).
