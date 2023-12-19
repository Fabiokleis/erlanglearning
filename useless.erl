-module(useless).
-export([say_hello/1, say_hello/0, fact/1, clear/0, greet_and_add_two/1]).
-define(sub(X,Y), X-Y).
% -import(io, [format/1]). % to import modules

add(A, B) ->
    A + B.

greet_and_add_two(X) ->
    add(X, ?sub(4,2)).

%% shows hello name.
say_hello(Name) -> 
    F = [N || N <- ["Hello dude ", Name, "\n"]],
    io:format(F).
say_hello() ->
    io:format("Hello unknown.~n").

clear() ->
    io:format("\ec").

%% erlang cool factorial func
fact(0) ->
    1;
fact(N) ->
    N * fact(N-1).
