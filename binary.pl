/* True if the list contains only binary values. */
membership(X,[X|_]).
membership(X,[_|T]) :-
          membership(X, T).
is_binary([]).
is_binary([H|L]) :-
          membership(H, [0, 1]),
          is_binary(L).

/* The same as is_binary_list except that the first parameter gives the length of the list. */
is_binary_n(N, L) :-
          length(L, N),
          is_binary(L).

/* A list containing all binary lists of a given length. */
binary_list(0, []).
binary_list(N, L) :-
          findall(L0, is_binary_n(N, L0), L).
