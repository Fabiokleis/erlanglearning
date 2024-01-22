-module(saddle_points).

-export([saddle_points/1]).

saddle_points([[]]) -> [];
saddle_points(Matrix) ->
    lists:filter(fun(X) -> X /= [] end, lists:concat([
     lists:foldl(
        fun({C, E}, Acc) -> 
            {Collumn, _} = lists:split(length(Matrix), [lists:nth(X, Y) || X <- lists:seq(C, length(R)), Y <- Matrix]),
            case lists:max(R) == E andalso lists:min(Collumn) == E of
                true -> [{I-1, C-1}|Acc];
                false -> Acc
            end
        end, [],
        lists:enumerate(lists:nth(I, Matrix))) || {I, R} <- lists:enumerate(Matrix)])).
