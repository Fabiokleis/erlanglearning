-module(fib).
-export([fib/1]).


fib(_, B, 0) -> B;
fib(A, B, N) ->
    fib(B, B+A, N-1).
    
fib(0) -> 0;
fib(N) ->    
    fib(0, 1, N-1).
