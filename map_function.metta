 ; Simple function to add two numbers
(= (addTwo $x $y) (+ $x $y))
 ; Binary map function that takes a binary function and expression
 ; (ussually a constant number) and a list, then performs the operation
 ; each elements of the list.
(= (map-expr $f $expr $xs)
    (if (or (== $expr ()) (== $xs ()))
        ()
        (let* (
                ($head (car-atom $xs))
                ($tail (cdr-atom $xs))
                ($head-new ($f $expr $head))
                ($tail-new (map-expr $f $expr $tail))
            )
        (cons-atom $head-new $tail-new)
    )
)
)

! (map-expr addTwo 10 (1 2 3))