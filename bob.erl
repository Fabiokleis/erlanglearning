-module(bob).

-export([response/1]).

check_whitespace(V) ->
    case V of
    	"\n" -> true;
    	"\t" -> true;
    	"\r" -> true;
    	" " -> true;
    	_ -> false
    end.

check_yell(V) ->
    case string:uppercase(V) of
	    V -> true;
	    _ -> false
    end.

check_alpha_upper(V) ->
    lists:member(V, "ABCDEFGHIJKLMNOPQRSTUVWSYZ").

check_alpha_lower(V) ->
    lists:member(V, "abcdefghijklmnopqrstuvwxyz").

check_alpha(V) -> check_alpha_upper(V) orelse check_alpha_lower(V).

check_numeric(V) ->
    case string:to_integer(V) of
	    {error, _} -> false;
	    _ -> true
    end.	

response(String, {alpha}) ->
    case lists:any(fun(X) -> check_alpha(X) end, String) of
        true -> "Calm down, I know what I'm doing!";
        false -> "Sure."
    end;

response(String, {alpha_upper}) ->
     case lists:any(fun(X) -> check_alpha_upper(X) end, String) of
         true -> "Whoa, chill out!";
         false -> "Whatever."
     end;                                                                       

response(String, {numeric}) ->
    case lists:all(fun(X) -> check_numeric([X]) end, String) of
	    true -> "Sure.";
    	false -> response(String, {alpha})
    end;

response(String, {question}) ->
    [H|T] = lists:reverse(string:trim(String)),
    case [H] of
	    "?" -> 
    	    case lists:all(fun(X) -> check_yell([X]) end, T) of
    		    true -> response(T, {numeric});
    		    false -> "Sure."
    	    end;
	    _ ->    
            case lists:all(fun(X) -> check_yell([X]) end, T) of
    		    true ->  response(T, {alpha_upper});
    		    false -> "Whatever."
    	    end
    end;

response(String, {whitespace}) ->
    case lists:all(fun(X) -> check_whitespace([X]) end, String) of
	    true -> "Fine. Be that way!";
	    false -> response(String, {question})
    end.

response(String) ->
    response(String, {whitespace}).
-module(bob).

-export([response/1]).

check_whitespace(V) ->
    case V of
    	"\n" -> true;
    	"\t" -> true;
    	"\r" -> true;
    	" " -> true;
    	_ -> false
    end.

check_yell(V) ->
    case string:uppercase(V) of
	    V -> true;
	    _ -> false
    end.

check_alpha_upper(V) ->
    lists:member(V, "ABCDEFGHIJKLMNOPQRSTUVWSYZ").

check_alpha_lower(V) ->
    lists:member(V, "abcdefghijklmnopqrstuvwxyz").

check_alpha(V) -> check_alpha_upper(V) orelse check_alpha_lower(V).

check_numeric(V) ->
    case string:to_integer(V) of
	    {error, _} -> false;
	    _ -> true
    end.	

response(String, {alpha}) ->
    case lists:any(fun(X) -> check_alpha(X) end, String) of
        true -> "Calm down, I know what I'm doing!";
        false -> "Sure."
    end;

response(String, {alpha_upper}) ->
     case lists:any(fun(X) -> check_alpha_upper(X) end, String) of
         true -> "Whoa, chill out!";
         false -> "Whatever."
     end;                                                                       

response(String, {numeric}) ->
    case lists:all(fun(X) -> check_numeric([X]) end, String) of
	    true -> "Sure.";
    	false -> response(String, {alpha})
    end;

response(String, {question}) ->
    [H|T] = lists:reverse(string:trim(String)),
    case [H] of
	    "?" -> 
    	    case lists:all(fun(X) -> check_yell([X]) end, T) of
    		    true -> response(T, {numeric});
    		    false -> "Sure."
    	    end;
	    _ ->    
            case lists:all(fun(X) -> check_yell([X]) end, T) of
    		    true ->  response(T, {alpha_upper});
    		    false -> "Whatever."
    	    end
    end;

response(String, {whitespace}) ->
    case lists:all(fun(X) -> check_whitespace([X]) end, String) of
	    true -> "Fine. Be that way!";
	    false -> response(String, {question})
    end.

response(String) ->
    response(String, {whitespace}).

