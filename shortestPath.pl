
/*
 *  (0,0)-----1----0-(0,1)\
 *    |                |   \
 *    |                |    1
 *    |                |     \
 *    |                |      \
 *    |                |       \
 *    6                3    (1,2)
 *    |                |       /
 *    |                |      /                       
 *    |                |     1
 *    |                |    /
 *    |                |   /
 *  (2,0)------1-----(2,1)
 *
 *  Facts
*/
edge((0,0),(0,1),1).
edge((0,0),(2,0),6).
edge((0,1),(2,1),3).
edge((2,1),(2,0),1).
edge((0,1),(1,2),1).
edge((1,2),(2,1),1).

/* Are two edges connected? */
connected(X, Y, C) :- edge(X, Y, C).
connected(X, Y, C) :- edge(Y, X, C).

path(X, Y, P, C) :- 
    walk(X, Y, [X], Q, C), 
    reverse(Q, P).

walk(X, Y, P, [Y|P], C) :- 
    connected(X,Y,C).

walk(X, Y, Visited, Path, C) :-
    connected(X, Z, D),           
    C \== Y,
    \+ member(Z, Visited),
    walk(Z, Y, [Z|Visited], Path, C1),
    C is D+C1.

shortest_path(A, B, P, C) :-
    findall([P1, C1], path(A, B, P1, C1), Paths),
    sort(Paths, Sorted),
    Sorted = [[P, C] | _].

