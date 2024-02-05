-module(kitchen).
-compile(export_all).

fridge1() ->
    receive
	{From, {store, _Food}} ->
	    From ! {self(), ok},
	    fridge1();
	{From, {take, _Food}} ->
	    %% uh....
	    From ! {self(), not_found},
	    fridge1();
	terminate ->
	    ok
    end.


%% Pid = spawn(kitchen, fridge2, [[baking_soda]]).
%% Pid ! {self(), {store, [baking_egg]}}.
%% flush(). %% Shell got {<0.89.0>,ok}
%% Pid ! {self(), {take, [baking_soda]}}
%% flush(). %% Shell got {<0.89.0>,{ok,[baking_soda]}}

fridge2(FoodList) ->
    receive
	{From, {store, Food}} ->
	    From ! {self(), ok},
	    fridge2([Food|FoodList]);
	{From, {take, Food}} ->
	    case lists:member(Food, FoodList) of
		true ->
		    From ! {self(), {ok, Food}},
		    fridge2(lists:delete(Food, FoodList));
		false ->
		    From ! {self(), not_found},
		    fridge2(FoodList)
	    end;
	terminate ->
	    ok
end.
    
count_letters(Pid, L, Word) ->
    Pid ! {freq, {L, length(lists:filter(fun(X) -> L == X end, Word))}}.

save_freq(Freqs, 0) -> Freqs;
save_freq(Freqs, Pids) ->
    receive
	{freq, Freq} -> 
	    save_freq([Freq|Freqs], Pids-1);
	V -> {badmatch, V}
    end.

dict(Strings) ->
    Text = lists:concat(Strings),
    Pids = [case lists:member(L, Text) of
		true -> spawn(?MODULE, count_letters, [self(), L, Text]);
		false -> 0
	    end || L <- lists:seq($a, $z)],
    dict:from_list(save_freq([], length(lists:uniq(Pids))-1)).
