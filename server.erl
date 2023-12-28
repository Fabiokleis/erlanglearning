-module(server).
-export([start/0]).	 
-define(SERVER_OPTIONS, binary, {ip, {192, 168, 0, 212}}, {packet, 0}, {active, false}).
	    
handle_client(Socket) ->
    ok = inet:setopts(Socket, [{active, once}]),
    receive
        {tcp, Socket, Data} ->
	    io:format("data: ~w~n", [Data]),
	    gen_tcp:send(Socket, Data),
	    handle_client(Socket);
        {tcp_closed, Socket} ->
            io:format("Socket ~w closed [~w]~n", [Socket, self()]),
            ok;
        {tcp_error, Socket, Reason} ->
            io:format("Error on socket ~p reason: ~p~n", [Socket, Reason])
    end.

handle_connections(ListenSocket) ->
    case gen_tcp:accept(ListenSocket) of
	{ok, Socket} -> 
	    spawn(fun() -> handle_connections(ListenSocket) end),
            handle_client(Socket);
	{error, Reason} -> 
	    io:format("Cannot accepts more socket connections: ~w~n", [{error, Reason}]),
	    ok
    end.

%% echo server
start() ->
    case gen_tcp:listen(8123, [?SERVER_OPTIONS]) of
	{ok, ListenSocket} -> 
	    spawn(fun() -> handle_connections(ListenSocket) end),
            io:get_chars("close server by pressing any key ", 1),
	    gen_tcp:close(ListenSocket);
	{error, Reason} -> io:format("unhandled situation: ~p~n", [{error, Reason}])
    end.
