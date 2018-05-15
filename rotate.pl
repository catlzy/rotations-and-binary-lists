/* True if the second list is obtained by rotating the first list one value to the left. */
/* Works given initial list or final list or both lists. */
rotate([H|T], L) :-
          append(T, [H], L), !.


/* Rotate a list N times. */
/* Doesn't work if given the final list but not the initial list. */
/* Doesn't work given the two lists but not the number of rotations. */
rotate_n(X, 0, X).
rotate_n(R, N, L) :-
          rotate(R, T),
          M is N-1,
          rotate_n(T, M, L).


/* True if the two lists are rotations of each other. */
/* Works given initial list or final list or both lists. */
rotation(R, L) :-
    append(H, T, R),
    append(T, H, L),
    T \= [].


/* True if the second parameter is a list containing all rotations of the first list. */
all_rotations([X], [X]).
all_rotations(R, A) :-
          findall(A0, rotation(R, A0), A).


/* Necklace - a string or list that is in its smallest rotation with respect to lexicographic (i.e. alphabetical) order. */
min_in_list([Min],Min).

min_in_list([H,K|T],M) :-
          compare(<, H, K),
          min_in_list([H|T],M).

min_in_list([H,K|T],M) :-
          compare(>, H, K),
          min_in_list([K|T],M).

necklace(L, NE) :-
          all_rotations(L, A),
          min_in_list(A, NE).
