-module(parallel_letter_frequency).

-export([dict/1, save_freq/3, count_letters/2, letter_freq/2]).

letter_freq(Str, Letter) ->
    {Letter, length(lists:filter(fun(X) -> Letter == X end, Str))}.	

count_letters(WordsPid, Str) ->
    WordsPid ! {word, lists:filter(fun({_, F}) -> F > 0 end, [letter_freq(Str, L) || L <- lists:seq($a, $z)])}.

save_freq(Parent, 0, Freqs) ->
    Parent ! {freqs, Freqs};
save_freq(Parent, Total, Freqs) ->
    receive
	{word, Word} -> 
	    case Freqs of
		[] -> save_freq(Parent, Total-1, Word);
		_ ->
		    Freq = [
			    case lists:search(fun({L, _}) -> L == Wl end, Freqs) of
				{value, {_, F}} -> {Wl, Wf + F};
				_ -> {Wl, Wf}
			    end
			    || {Wl, Wf} <- Word],
		    save_freq(Parent, Total-1, lists:uniq(fun({L, _}) -> L end, Freq ++ Freqs))
	    end;
	V -> {badmatch, V}
    end.

dict(Strings) ->
    WordsPid = spawn(?MODULE, save_freq, [self(), length(Strings), []]),
    [spawn(?MODULE, count_letters, [WordsPid, Str]) || Str <- Strings],
    
    receive 
	{freqs, Freqs} -> dict:from_list(Freqs);
	V -> {badmatch, V}
    end.
