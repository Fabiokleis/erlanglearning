-module(pattern).
-export([greet/2]).
-export([valid_time/1]).
-export([head/1, second/1, tail/1]).
-export([same/2]).

greet(he, Name) ->
    io:format("Hello ~s!~n", [Name]); % string interpolation
greet(she, Name) ->
    io:format("Hello ~s!~n", [Name]);
greet(they, Names) ->
    io:format("Hello ~p!~n", [Names]); % pretty interpolation
greet(fl, Num) ->
    io:format("float: ~30f~n", [Num]); % float with 30 spaces
greet(int, Num) ->
    io:format("int: ~B~n", [Num]); % integer
greet(_, _) ->
    io:format("Unknown.~n").

valid_time({Date = {D, M, A}, Time = {H, Min, S}}) ->
    io:format("A tupla date (~p) mostra: ~p/~p/~p~n", [Date, D, M, A]),
    io:format("A tupla time (~p) mostra: ~p:~p:~p~n", [Time, H, Min, S]);
valid_time(_) ->
    io:format("especifique a data e hora Date = {D, M, A} e Time = {H, Min, S}~n").

%% | -> cons operator
head([]) -> [];
head([H|_]) -> H.

second([]) -> [];
second([_]) -> [];
second([_,S|_]) -> S.

tail([]) -> [];
tail([T]) -> T;
tail([_|T]) -> tail(T).

same(X,X) ->
    true;
same(_,_) ->
    false.
