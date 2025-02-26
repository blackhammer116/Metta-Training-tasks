 ; A function used for indexing lists
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

 ; A function to get the length of a list
(= (length $list $n)
    (if (== $list ()) ()
        (let* (
                ($head (car-atom $list))
                ($tail (cdr-atom $list))
                ($rest (length $tail (+ $n 1)))
            )
        $n
    )
)
)

 ; Merge function to combine two sorted lists
(= (merge $left $right)
    (if (== $left ())
        $right
        (if (== $right ())
            $left
            (let* (
                    ($left-head (car-atom $left))
                    ($right-head (car-atom $right))
                )
            (if (< $left-head $right-head)
                (cons $left-head (merge (cdr-atom $left) $right))
                (cons $right-head (merge $left (cdr-atom $right)))
            )
    )
)
)
)

 ; A function to get sublists, if $i == 0 it will retrive the left side
 ; if $i is not set it will get the right sublist
(= (sublist $list $i $mid)
    (if (== $i ())
        (let* (
                ($head (index $list 0 $mid))
                ($j (if (== (length $list) $mid) () (+ $mid 1)))
            )
            (cons-atom $head (sublist $list $i $j))
        )
        (let* (
                ($head (index $list 0 $i))
                ($j    (if (> $i $mid) () (+ $i 1)))
            )
            (cons-atom $head (sublist $list $j $mid))

        )
    )
)

 ; Merge sort function
(= (mergeSort $list)
    (if (<= (length $list 0) 1)
        $list
        (let* (
                ($mid (/ (length $list) 2))
                ($left (sublist $list 0 $mid))
                ($right (sublist $list () $mid))
            )
        (merge (mergeSort $left) (mergeSort $right))
    )
)
)

! (mergeSort (3 2 1 4 2 6 8))