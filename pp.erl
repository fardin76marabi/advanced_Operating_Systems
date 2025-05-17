-module(pp).
-import(lists,[nth/2]).
-compile(export_all).
	
f()->
	process_flag(trap_exit, true),
	receive
		{'EXIT', Pid, P} ->io:fwrite("master restarting dead slave ~p~n", [P]),
							   ok;
		{M,P} ->io:format("Slave ~p got message ~p~n", [P, M]),
				ok
    end,
	f().

send(M,P)->
	Pid=whereis(list_to_atom(integer_to_list(P))),
	if 
      M==die -> 
		 exit(Pid,P);	
      true -> 
		 Pid ! {M,P}	 
    end.
	
loop(0) ->
	ok;
loop(Count) ->
    process_flag(trap_exit, true),
	Pid=spawn_link(fun f/0),
    register(list_to_atom(integer_to_list(Count)),Pid),
    loop(Count-1).

	
start(N)->
   spawn(fun()-> loop(N) end).  
	
