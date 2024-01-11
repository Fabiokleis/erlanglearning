-module(diamond).
-export([rows/1]).

%% A

%% .A.
%% B.B
%% .A.

%% ..A..
%% .B.B.
%% C...C
%% .B.B.
%% ..A..

spaces(N) -> lists:concat(lists:duplicate(N, " ")).

row([{_, C}|_], Tot, 0, Acc) -> 
    Row = [C] ++ spaces(Tot-2) ++ [C],
    lists:reverse([Row|Acc]);

row([{1, _}|T], Tot, SpcAcc, Acc) -> 
    Row = spaces(SpcAcc-1) ++ "A" ++ spaces(SpcAcc-1),
    row(T, Tot, SpcAcc-2, [Row|Acc]);
    
row([{Idx, C}|T], Tot, SpcAcc, Acc) ->
    Mspc = Tot - (SpcAcc*2 + 2),
    Row = spaces(SpcAcc) ++ [C] ++ spaces(Mspc) ++ [C] ++ spaces(SpcAcc),
    row(T, Tot, SpcAcc-1, [Row|Acc]).

rows("A") -> ["A"];
rows(Letter) -> 
    Alpha = [X || X <- lists:enumerate(lists:seq(65, hd(Letter)))],
    {Idx, _} = lists:last(Alpha),
    Fh = row(Alpha, length(Alpha)*2-1, Idx, []),
    Fh ++ tl(lists:reverse(Fh)).
