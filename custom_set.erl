-module(custom_set).

-export([add/2, contains/2, difference/2, disjoint/2, empty/1, equal/2, from_list/1, intersection/2, subset/2,
	 union/2]).


add(Elem, Set) -> 
    case lists:member(Elem, Set) of
        false -> [Elem|Set];
        true -> Set
    end.

contains(Elem, Set) -> lists:member(Elem, Set).
    
difference(Set1, Set2) -> 
    Set1 -- Set2.

disjoint(Set1, Set2) -> 
    intersection(Set1, Set2) == [].

empty([]) -> true;
empty(_) -> false.

equal(Set1, Set2) when length(Set1) >= length(Set2) ->
    Set1 -- Set2 == [];
equal(Set1, Set2) ->
    Set2 -- Set1 == [].

from_list(List) -> 
    lists:uniq(List).

intersection(Set1, Set2) when length(Set1) >= length(Set2) ->
    Set1 -- (Set1 -- Set2);
intersection(Set1, Set2) ->
    Set2 -- (Set2 -- Set1).

subset([], []) -> true;
subset([], _) -> true;
subset(_, []) -> false;
subset(Set1, Set2) when length(Set1) == length(Set2) ->
    intersection(Set1, Set2) == [] orelse equal(Set1, Set2);
subset(Set1, Set2) ->
    not disjoint(Set1, Set2).

union(Set1, Set2) -> 
    Set1 ++ Set2 -- Set1.

