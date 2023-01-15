open Tools
open Graph

let nb_nodes g = n_fold g (fun acc _ -> acc + 1) 0

let find_path gr ids idp =
  (*Keeping track of the visited nodes*)
  let visited = Hashtbl.create (nb_nodes gr) in
  (*listing the node to be visited in the queue*)
  let queue = Queue.create () in
  (*flag to avoid an infinite loop at first had a probleme without the flag and 
     i didn't know where was the cause of the infinite loop*)
  let found = ref false in 
  let rec aux gr ids =
    (* used to debug : let () = Printf.printf("current node%d \n") ids in (); *)

    if ids = idp then begin
      found := true;
      [idp] 
    end else if Hashtbl.mem visited ids then
      []
    else begin
      Hashtbl.add visited ids ();
      (*get the outgoing arcs from the current node*)
      let out = out_arcs gr ids in
      (*classique BFS algorithm*)
      List.iter (fun (x, _) ->
        if not (Hashtbl.mem visited x) then
          Queue.push x queue
      ) out;
      if Queue.is_empty queue then
        []
      else
        let next = Queue.pop queue in
        (*I don't know if this if statement is relevant i, it verifies if the node is visited then we call the function aux *)
          if not (Hashtbl.mem visited next) then
            next :: aux gr next
          else
            []
    end
  in
  let path = ids :: aux gr ids in
  if !found then path else []
;;

let min_capacity g m = 
  e_fold g (fun min_cap id1 id2 lbl -> min min_cap lbl) m
;;

let rec adjust_graph g l value = 
  e_fold g (fun g id1 id2 _ -> add_arc g id1 id2 value) g
;;

let fordfulkerson g ids idp =
  let flow_init = clone_nodes g in
  let m = max_int in
  let rec aux residual_graph flow =
    let () = Printf.printf("find path in aux \n") in ();
    match List.rev (find_path residual_graph ids idp) with
    | [] -> flow
    | path -> 
      let m = min_capacity residual_graph m in 
      let residual_graph = adjust_graph residual_graph path (-m) in
      let flow = adjust_graph flow path m in
      aux residual_graph flow
  in
  aux g flow_init
;;