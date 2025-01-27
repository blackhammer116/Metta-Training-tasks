 ; dec is defined to decrement any given number by 1
(= (dec $x) (- $x 1))
 ; Here sum_range takes a number as an argument which is the limit/range
 ; then checks if the number is a multiple of 5 or 3 by using mod operator
 ; if its true then it will sum it, otherwise it will skip to the next value
(= (sum_range $h)
    (let $s (dec $h)
        (if (> $s 0)
            (if (or (== 0 (% $s 3)) (== 0 (% $s 5)))
                (+ $s (sum_range $s))
                (sum_range $s)
            )
        0
    )
)
)
! (sum_range 10)