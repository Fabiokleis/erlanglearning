-module(triangle).

-export([kind/3]).

kind(0, 0, 0) -> {error, "all side lengths must be positive"};
kind(A, B, C) when 
                  A + B >= C andalso
                  B + C >= A andalso
                  A + C >= B
                  -> 
    if 
        A == B andalso B == C -> equilateral;
        A == B orelse A == C orelse B == C -> isosceles;
        true -> scalene
    end;
kind(_, _, _) -> {error, "side lengths violate triangle inequality"}.
