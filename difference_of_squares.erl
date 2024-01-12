-module(difference_of_squares).

-export([difference_of_squares/1, square_of_sum/1, sum_of_squares/1]).


difference_of_squares(Number) -> 
    square_of_sum(Number) - sum_of_squares(Number).

%%floor(math:pow(lists:foldl(fun (X, Acc) -> X + Acc end, 0, lists:seq(1, Number)), 2)).
% ((Number*Number) + (2*Number) - (Number-1)) div 2,
square_of_sum(Number) -> 
    Sum = (Number*Number+Number) div 2, 
    Sum*Sum.
    

sum_of_squares(Number) -> 
    lists:foldl(fun (X, Acc) -> Acc + floor(math:pow(X, 2)) end, 0, lists:seq(1, Number)).

