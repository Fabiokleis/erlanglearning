-module(complex_numbers).

-export([abs/1, add/2, conjugate/1, divide/2, equal/2, exp/1, imaginary/1, mul/2, new/2,
	 real/1, sub/2]).
-define(E, 2.71828182845904509080).

%% i² = -1
%% i = sqrt(-1)
%% z = a + bi

abs(Z) -> 
    {R, I} = Z,
    math:sqrt((R*R) + (I*I)).

add(Z1, Z2) -> 
    {R1, I1} = Z1,
    {R2, I2} = Z2,
    {R1+R2, I1+I2}.

conjugate(Z) -> 
    %% |z|² = z * conjugate,
    %% conjugate = |z|²/ z,
    divide({math:pow(complex_numbers:abs(Z), 2), 0}, Z).

divide(Z1, Z2) -> 
    {R1, I1} = Z1,
    {R2, I2} = Z2,
    {(R1 * R2 + I1 * I2)/(R2 * R2 + I2 * I2), (I1 * R2 - R1 * I2)/(R2 * R2 + I2 * I2)}.

equal(Z1, Z2) ->
    {R1, I1} = Z1,
    {R2, I2} = Z2,
    erlang:abs(R1 - R2) =< 0.005 andalso erlang:abs(I1 - I2) =< 0.005.

exp(Z) -> 
    {R, I} = Z,
    EeA = math:pow(?E, R),
    {math:cos(I) * EeA, math:sin(I) * EeA}.

imaginary(Z) -> 
    {_, I} = Z,
    I.

mul(Z1, Z2) ->
    {R1, I1} = Z1,
    {R2, I2} = Z2,
    {R1 * R2- I1 * I2, R1 * I2 + R2 * I1}.
    
new(R, I) -> {R, I}.
    
real(Z) -> 
    {R, _} = Z,
    R.

sub(Z1, Z2) -> 
    {R1, I1} = Z1,
    {R2, I2} = Z2,
    {R1-R2, I1-I2}.