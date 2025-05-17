# advanced_Operating_Systems
This project focuses on understanding and implementing the concepts of the Master-Slave model in multitasking systems. 

Master/Slave Project

This problem demonstrates a scenario where a master process supervises slave processes.
In a real-world example, a slave could control hardware units, while the master ensures all slaves are functional. If a slave crashes (e.g., due to hardware failure), the master must restart it.
Module pp Requirements
Functions

    start(N)

        Starts the master process and instructs it to launch N slave processes.

        Slaves must register themselves with the master.

    send(Message, N)

        Sends Message to the master, which forwards it to slave number N.

        If the message is die, the slave must terminate (and be restarted by the master).

Key Behaviors

✓ The master must detect crashed slaves, restart them, and log the action.
✓ Slaves should print all received messages except die.
Implementation Hints

    The master should:

        Trap exit signals.

        Maintain a list of slave PIDs with their IDs.

        Monitor slaves via links.

Example Usage
erlang

> pp:start(10).  
=> true  
> pp:send(hello, 6).  
=> {hello, 6}  
Slave 6 got message hello  
> pp:send(die, 8).  
=> {die, 8}  
master restarting dead slave 8  

Notes

    Use Erlang’s link/1 and process_flag(trap_exit, true) for supervision.

    Slave termination triggers the master’s restart logic.
