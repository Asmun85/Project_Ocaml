open Tools
open Graph

(*data :int graph (edegs are integers)
        id (source) +  id (dest)
        returns the list of nodes from source to dest*)

val nb_nodes : 'a graph -> int
val find_path : int graph -> id -> id -> id list
val min_capacity : int graph -> int -> int
(* val adjust_graph : int graph -> id list -> int -> int graph *)
val adjust_graph : int graph -> id list -> int -> int graph


val fordfulkerson : int graph -> id -> id -> int graph
