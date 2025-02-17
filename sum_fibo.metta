 ; function that decrements any number by 1
(= (dec $x) (- $x 1))
 ; A function to calculate the fibonacci value of the given term
 ; if given i it calculates the i's term value
(= (fibo $y)
    (if (<= $y 0)
        0
        (if (== $y 1)
            1
            (+ (fibo (- $y 1)) (fibo (- $y 2)))
        )
)
)
 ; A function that sums all the even fibonacci value with in the given
 ; range/limit
(= (sum_fibo $h)
    (if (> $h 0)
        (let $fib (fibo $h)
            (if (== 0 (% $fib 2))
                (+ $fib (sum_fibo (dec $h)))
                (sum_fibo (dec $h))
            )
    )
0
)
)

! (sum_fibo 100)