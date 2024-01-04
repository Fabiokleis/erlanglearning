-module(strain).

-export([keep/2, discard/2]).

keep(Fn, List) ->
  [X || X <- List, Fn(X)].

discard(Fn, List) ->
  [X || X <- List, not Fn(X)].

