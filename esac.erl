-module(esac).
-export([insert/2, beach_temp/1, tail/1]).

% erlang case

insert(X, []) ->
    [X];
insert(X, Set) ->
    case lists:member(X, Set) of
	true -> Set;
	false -> [X|Set]
    end.

beach_temp(Temperature) ->
    case Temperature of
	{celsius, N} when N >= 20, N =< 45 ->
	    'favorable in the BR';
	{kelvin, N} when N >= 293, N =< 318 ->
	    'scientifically favorable';
	{fahrenheit, N} when N >= 68, N =< 113 ->
	    'favorable in the US';
	_ -> 'avoid bead'
    end.

% recursive tail using case 
tail(L) ->
    case L of
	[] -> [];
	[T] -> T;
	[_|T] -> tail(T)
    end.      
