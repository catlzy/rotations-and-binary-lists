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


/* binary de Bruijn. is_bruijn decides if the list is a binary de Bruijn of the given length. */
/* Only works when both arguments are given. */

/* helper1: True if the two lists are rotations of each other. */
rotation(R, L) :-
    append(H, T, R),
    append(T, H, L),
    T \= [].

/* helper2: Find all rotations of a given list. */
all_rotations([X], [X]).
all_rotations(R, A) :-
          findall(A0, rotation(R, A0), A).

/* helper3: Decides if a list is a sublist of another list. */
my_sublist(S, L) :-
          append([_, S, _], L).

/* helper4: Decides if a list is a sublist of any list in a list of lists. */
all_list(L, [H|AL]) :-
          my_sublist(L, H);
          all_list(L, AL).

/* helper5: Decides if all lists in a list of lists are a sublist of another list in a list of lists. */
all_subset([], _).
all_subset([H|R], L) :-
          all_list(H, L),
          all_subset(R, L).

is_bruijn(N, B) :-
          length(B, M),
          pow(2, N, M),
          binary_list(N, L),
          all_rotations(B, A),
          all_subset(L, A).
