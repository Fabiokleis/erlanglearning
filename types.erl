-module(types).
-export([convert_l_to_i/1]).
-export([convert_l_to_bits/1]).
-export([convert_bits_to_list/1]).
-export([convert_t_to_list/1]).
-export([series/2]).
-export([series_tuple/2]).

%% is_builtin(module, fun, arity).
%% is_builtin(erlang, is_tuple, 1).
%% is_builtin(erlang, is_bitstring, 1).
%% is_builtin(erlang, is_list, 1).
%% is_builtin(erlang, is_integer, 1).
%% is_builtin(erlang, is_float, 1).


convert_l_to_i(V) ->
    integer_to_list(V). %% modulo padrao erlang

convert_l_to_bits(V) ->
    erlang:list_to_bitstring(V). 

convert_bits_to_list(A) ->
    bitstring_to_list(A).

convert_t_to_list(L) ->
    tuple_to_list(L).

serie_tuple(Dst, Str, N, Acc) when N > 0 ->
    case length(Str) + 1 of
 	    N -> Dst;
 	    _ -> serie_tuple(erlang:insert_element(Acc, Dst, lists:sublist(Str, N)), tl(Str), N, Acc+1)
     end.

series_tuple(N, Str) when N > 0 andalso length(Str) >= N ->
    serie_tuple({}, Str, N, 1).

%% exercism
serie(Dst, Str, N) ->
    case length(Str) + 1 of
	    N -> Dst;
	    _ -> serie(Dst ++ [lists:sublist(Str, N)], tl(Str), N)
    end.

series(N, Str) when N > 0 andalso length(Str) >= N ->
    serie([], Str, N).
