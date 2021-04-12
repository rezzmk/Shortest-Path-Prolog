/** 
 * Marcos Caramalho
 *
 * Towers of Hanoi
 * https://en.wikipedia.org/wiki/Tower_of_Hanoi
 */

/* Facts for the attached example_graph.png weighted directed graph */
edge((0,0),(0,1),1).
edge((0,0),(2,0),6).
edge((0,1),(2,1),3).
edge((2,1),(2,0),1).
edge((0,1),(1,2),1).
edge((1,2),(2,1),1).

/* Checks is two nodes are connected 
 * 
 * Since we're dealing with a directed graph, we need to check for uni-directionality
 */
connected(X, Y, C) :- edge(X, Y, C) , not(edge(Y, X, C)). %! X --> Y && Y -/-> X

path(X, Y, P, C) :- 
    walk(X, Y, [X], Q, C),
    reverse(Q, P).

walk(X, Y, P, [Y | P], C) :- connected(X, Y, C).
walk(X, Y, V, P, C) :-
    connected(X, Z, C1),
    C \== Y,
    \+ member(Z, V),
    walk(Z, Y, [Z | V], P, C2),
    C is C1 + C2.

shortest_path(A, B, P, C) :-
    findall([P, C], path(A, B, P, C), Paths), %! Find all paths, store it into Paths
    sort(Paths, Sorted),
    Sorted = [[P, C] | _].

/*
 * A simpler solution, but perhaps not cycle-safe, would be:
 *
 *   path(X, Y, [X, Y], C) :- edge(X, Y, C).
 *   path(X, Y, P, C) :-
 *   edge(X, Z, C1),
 *   path(Z, Y, P1, C2),
 *   P = [X | P1],
 *   C is C1 + C2.
 */
