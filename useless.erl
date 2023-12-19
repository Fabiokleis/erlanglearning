-module(useless).
-export([imc/2, say_hello/1, say_hello/0, fact/1, clear/0, greet_and_add_two/1]).
-define(sub(X,Y), X-Y).
% -import(io, [format/1]). % to import modules
-import(imc, [calcula/2]).

-author("An Erlang Champ").

imc(Peso, Altura) ->
    imc:calcula(Peso, Altura).

add(A, B) ->
    A + B.

greet_and_add_two(X) ->
    add(X, ?sub(4,2)). %% C-like macro ?

%% function overload by arity
%% shows hello name.
say_hello(Name) -> 
    F = [N || N <- ["Hello dude ", Name, "\n"]],
    io:format(F).
say_hello() ->
    io:format("Hello unknown.~n").

%% clear sucks in emacs
clear() ->
    io:format("\ec").

%% erlang cool factorial func
fact(0) -> 1;
fact(N) -> N * fact(N-1).

%% export_all to call from erl shell
private() ->
    "Aqui Não!".
