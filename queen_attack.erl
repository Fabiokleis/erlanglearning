-module(queen_attack).

-export([can_attack/2]).

can_attack({Q1c, _}, {Q1c, _}) -> true;
can_attack({_, Q1r}, {_, Q1r}) -> true;
can_attack({Q1c, Q1r}, {Q2c, Q2r}) -> 
    abs(Q1r - Q2r) == abs(Q1c - Q2c).
