-module(space_age).

-export([age/2]).
-define(EY, 31557600).

age(earth, Sec, W) -> Sec/(?EY*W).

age(uranus, Sec) ->
    age(earth, Sec, 84.016846);
age(saturn, Sec) ->
    age(earth, Sec, 29.447498);
age(neptune, Sec) ->
    age(earth, Sec, 164.79132);
age(jupiter, Sec) ->
    age(earth, Sec, 11.862615);
age(mars, Sec) ->
    age(earth, Sec, 1.8808158);
age(venus, Sec) ->
    age(earth, Sec, 0.61519726);
age(mercury, Sec) ->
    age(earth, Sec, 0.2408467);
age(earth, Sec) ->
    Sec/?EY.    

