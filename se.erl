-module(se).
-export([heh_fine/0, oh_god/1, help_me/1]).
%% erlang if

heh_fine() ->
    if 1 =:= 1 ->
        works
    end,
    if 1 =:= 2 andalso 1 =:= 1 ->
        works
    end,
    if 1 =:= 2 andalso 1 =:= 1 ->
	fails
    end.

oh_god(N) ->
    if N =:= 2 -> might_succed;
	true -> always_does %% this is erlang's if's 'else!'
    end.


help_me(Animal) ->
    Talk = if Animal == cat -> "meow";
	      Animal == beef -> "moo";
	      Animal == dog -> "bark";
	      Animal == tree -> "bark";
	      true -> "something" %% avoid using true as else clause, use the logical inverse of all clauses sajsuauhausha.
	   end,
    {Animal, "Says " ++ Talk ++ "!"}.
