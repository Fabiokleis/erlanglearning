-module(guards).
-export([old_enough/1, right_age/1, wrong_age/1]).
%% erlang guards 

old_enough(X) when X >= 18 -> true;
old_enough(_) -> false.


% , -> andalso checks only one side if it true
right_age(X) when X >= 18, X =< 104 ->
    true;
right_age(_) -> false.

% ; -> orelse checks both sides
wrong_age(X) when X < 18; X > 104 ->
    true;
wrong_age(_) -> false.
