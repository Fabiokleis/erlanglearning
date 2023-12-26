-module(leap).

-export([leap_year/1]).


leap_year(Year) -> 
    case Year of
        A when A rem 4 == 0 andalso A rem 100 /= 0 ->
            true;
        A when A rem 4 == 0 andalso A rem 100 == 0 andalso A rem 400 == 0 ->
            true;
        _ -> false
    end.

