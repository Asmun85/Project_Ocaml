open Tools
open Graph



(* On donne un graphe + les id des nodes source & puits -> la fonction renvoie un chemin & la valeur de flot minimale sur ce chemin *)
val find_path : int graph -> id -> id -> id list

(* cette fonction trouve la capacité minimale d'un chemin donné *)
val min_capacity : int graph -> id list -> int -> int

(* cette fonction ajoute une valeur à tous les arcs d'une liste donnée dans un graphe*)
val adjust_graph : int graph -> id list -> int -> int graph

(* l'algorithme *)
val run : int graph -> id -> id -> int graph