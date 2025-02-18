;; Implementing get_last element of the list
(= (get_last (:: $x $y))
    (let $s
        (if (== $y ())
            $x
            (get_last $y)
        )
        $s
    )
)
;! (get_last (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 ()))))))

;; Appeding to the start of the list
(= (append_start $y $xs)
    (:: $y $xs)
)
; !(append_start 0 (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 ()))))))

;; Appending an element to the end of the list
(= (append_end $y (:: $x $xs))
    (if (== $xs ())
        (:: $x (:: $y ()))
        (:: $x (append_end $y $xs))
    )
)

; !(append_end  (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 ()))))))

(= (length ()) 0)

(= (length $x)
    (let*
        (
            ($num (cdr-atom $x))
            ($tail (cdr-atom $num))
        )
        ($tail)
    )
)

; !(length (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 ()))))))

;; A function that extracts numbers from the list into the form (1 2 3 4 5)
(= (extract (:: $x $xs))
    (let*
        (
            ($y (if (== $xs ()) () (extract $xs)))
        )
        (cons-atom $x $y)
    )
)

; !(extract (:: 1 (:: 2 (:: 3 (:: 4 (:: 5 ()))))))

;; A function that returns the length of the list in the form (1 2 3 4)
(= (new_length $x)
    ( if (== $x ())
        0
        (+ 1 (new_length (cdr-atom $x)))
    )
)
; !(new_length (1 2 3 4))

;; A function that sums expressions of the same length
(= (sum_expr $x $y)
    (if (and (== (new_length $x) (new_length $y)) (not (== $x ())))
        (let*
            (
                ($head1 (car-atom $x))
                ($head2 (car-atom $y))
                ($sumHead (+ $head1 $head2))
                ($tail1 (cdr-atom $x))
                ($tail2 (cdr-atom $y))
            )
            (cons-atom $sumHead ((sum_expr $tail1 $tail2)))
        )
        ()
    )
)
; ! (sum_expr (1 2 3) (1 2 3))

;; A function that takes the element at the given index
;; $ctr is the control index in which we wish to start from
(= (index $list $ctr $index)
    (if (== $list ())
        ()
        (let* (
                ($head (car-atom $list))
                ($tail (cdr-atom $list))
                ($rest (index $tail (+ 1 $ctr) $index))
            )
        (if (== $ctr $index)
            $head
            $rest
        )
)
)
)

; !(index (1 2 3 4) 0 3)
;; This is a helper function for the slice function
(= (reverse-list $list $reversed)
    (if (== $list ())
        $reversed
        (reverse-list (cdr-atom $list) (cons-atom (car-atom $list) $reversed))  ; Recursive call
    )
)
;; A function that slices a list based on the given start point($ctr) and end point($index)
(= (slice $index $ctr $list)
	(let*
		(
		($s (index $list $ctr $index))
		($xs (if (== $index 0) () (slice (- $index 1) $ctr $list)))
		($y (cons-atom $s $xs))
		)
        $y
    )
)

; !(reverse-list (slice 2 0 (1 2 3 4)) ())

(= (reconstruct $expr)
    (if (== $expr ())
        ()
        (let*
            (
                ($head (car-atom $expr))
                ($tail (cdr-atom $expr))
            )
            (if (== (new_length $expr) 1)
                (println! ($head (reconstruct $tail)))
            )
        )
    )
)

;; Test the function with an example list
!(reconstruct (B 4 5 3))
