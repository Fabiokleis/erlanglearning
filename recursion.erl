-module(recursion).
-export([game/1]).

guess_number(Answer, Try) ->
    io:format("Try to guess the random number, you have [~p] chances.~n", [Try]),
    {ok, [Guess]} = io:fread("guess: ", "~d"), 
    case Try of 
	1 when Guess /= Answer -> 
	    io:format("You lost your chances.~n");
	T when T > 0 andalso Guess == Answer -> 
	    io:format("You are right, the random number was ~p.~n", [Answer]);
	T when T > 0 andalso Guess > Answer ->
	     io:format("Your guess are bigger than the random number.~n"),
	    guess_number(Answer, Try-1);
	T when T > 0 andalso Guess < Answer ->
	    io:format("Your guess are smaller than the random number.~n"),
	    guess_number(Answer, Try-1)
    end.

game(Try) ->
    guess_number(rand:uniform(100), Try).
