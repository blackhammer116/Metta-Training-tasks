;; is_empty helper function
(= (is_empty $list)
    (if (== $list ())
        True
        False
    )
)


; Length
(= (length $list)
    (if (== $list ())
        0
        (let*
            (
                ($head (car-atom $list))
                ($tail (cdr-atom $list))
            )
            (+ 1 (length $tail))
        )
    )
)

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
; ! (map-expr addTwo 10 (1 2 3))

;; is_member
(= (is_member $y $list)
    (if (== $list ())
        False
        (let*
            (
                ($head (car-atom $list))
                ($tail (cdr-atom $list))
            )
            (if (== $y $head)
                True
                (is_member $y $tail)
            )
        )
    )
)
; !(is_member 1 (1 2 3 4 5))

;; Push
(= (push $y $list)
    (cons-atom $y $list)
)
; !(push 1 (2 3 4 5 6))

;; Pop
; helper function to extract redundant brackets out of the list
; Eg: (1 (2 (3 (4 ())))) -> (1 2 3 4)
(= (extract ()) ())
(= (extract ($x $xs))
    (let*
        (
            ($y (if (== $xs ()) () (extract $xs)))
        )
        (cons-atom $x $y)
    )
)

(= (pop $list)
    (let*
        (
            ($head (car-atom $list))
            ($tail (cdr-atom $list))
        )
        (if (== $tail ())
            ()
            ($head (pop $tail))
        )
    )
)

; !(extract (pop (1 2 3 4 5)))

;; Append at the end of the list
(= (append $y $list)
    (let*
        (
            ($head (if (== $list ()) () (car-atom $list)))
            ($tail (cdr-atom $list))
        )
        (if (== $head ())
            ($y ())
            ($head (append $y $tail))
        )
    )
)

; !(extract (append 1 (2 3 4 5)))


;; Remove element
(= (remove_element $y $list)
    (let*
        (
            ($head (if (== $list ()) () (car-atom $list)))
            ($tail (cdr-atom $list))
        )
        (if (== $y $head)
            (remove_element $y $tail)
            (if (== $head ())
                ()
                ($head (remove_element $y $tail))
            )
        )
    )
)

; !(extract (remove_element 2 (1 2 3 4 5)))

;; Reverse
(= (reverse $list)
    (let*
        (
            ($head (car-atom $list))
            ($tail (cdr-atom $list))
        )
        (if (== $tail ())
            ($head)
            ((reverse $tail) $head)
        )
    )
)
; !(reverse (1 2 3 4 5))

;; Filter
; helper function to apply to filter
(= (odd $x)
    (if (not (== (% $x 2) 0))
        True
        False
    )
)
(= (filter $f $list)
    (if (== $list ())
        ()
        (let*
            (
                ($head (car-atom $list))
                ($tail (cdr-atom $list))
            )
            (if (== ($f $head) True)
                ($head (filter $f $tail))
                (filter $f $tail)
            )
        )
    )
)

; !(extract (filter odd (1 2 3 4 5)))

;; Foldl
(= (foldl $f $list $null)
    (if (== $list ())
        $null
        (let*
            (
                ($head (car-atom $list))
                ($tail (cdr-atom $list))
                ($n    ($f $head (foldl $f $tail $null)))
            )
            $n
        )
    )
)

; !(foldl + (1 2 3 4 5) 0)

; (= (foldr $f $list $null)
;     (if (== $list ())
;         $null
;         (let*
;             (
;                 ($head (car-atom $list))
;                 ($tail (cdr-atom $list))
;                 ($n    ($f (foldr $f $tail $null) $head))
;             )
;             $n
;         )
;     )
; )
; !(foldr + (1 2 3 4 5) 0)

;; max_value
(= (max_value $list $i)
    (if (is_empty $list)
        $i
        (let*
            (
                ($head (car-atom $list))
                ($tail (cdr-atom $list))
                ($max (if (> $head $i) (max_value $tail $head) (max_value $tail $i)))
            )
            $max
        )
    )
)
; !(max_value (1 2 3 4 5) 0)


;; mix_value
;; helper function to find the smallest of two numbers
(= (find_small $x $y)
    (if (< $x $y)
        $x
        $y
    )
)
(= (find_big $x $y)
    (if (> $x $y)
        $x
        $y
    )
)
(= (min_value $list $i)
    (if (is_empty $list)
        $i
        (let*
            (
                ($head (car-atom $list))
                ($tail (cdr-atom $list))
                ($max  (min_value $tail (find_small $head $i)))
            )
            $max
        )
    )
)
; !(min_value (1 2 3 4 5) 10)
;; helper functions
(: isSymbol (-> Expression Bool))
(= (isSymbol $expr) (== (get-metatype $expr) Symbol))

;; Function to replace a given atom from a space.
(: appendAtom (-> Atom Atom Atom))
(= (appendAtom $a $atom) (foldr cons-atom ($a) $atom))

(: foldr (-> (-> $a $b $b) $b $c $d))
(= (foldr $f $i $xs)
   (if (== $xs ())
       $i
       (let* (($h (car-atom $xs))
              ($t (cdr-atom $xs))
              ($ft (foldr $f $i $t)))
         ($f $h $ft)
        )
    )
)


(= (++ $x $y)
   (case ((isSymbol $x) (isSymbol $y))
      (
        ((True True)  ($x $y))
        ((True False) (cons-atom $x $y))
        ((False True) (appendAtom $y $x))
        ((False False)  (foldr cons-atom $y $x)))))



;; Sorting
(= (sort_list $list)
  (if (<= (length $list) 1)
      $list
      (let*
            (
                ($pivot  (car-atom $list))
                ($rest   (cdr-atom $list))
                ($left   (extract (find_smallest $pivot $rest)))
                ; (() (println! ($left (length $left))))
                ($left' (sort_list $left))
                (() (println! $left'))
                ($right  (extract (find_largest $pivot $rest)))
                ; (() (println! ($right (length $right))))
                ($right' (sort_list $right))
                (() (println! $right'))
                ($right2  (cons-atom $pivot $right'))
                ($total (++ $left $right2))
            )
            $total
        )
    )
)
(= (find_smallest $pivot $list)
    (if (== $list ())
        ()
        (let*
            (
                ($head (car-atom $list))
                ($tail (cdr-atom $list))
            )
            (if (> $pivot $head)
                ($head (find_smallest $pivot $tail))
                (find_smallest $pivot $tail)
            )
        )
    )
)
(= (find_largest $pivot $list)
    (if (== $list ())
        ()
        (let*
            (
                ($head (car-atom $list))
                ($tail (cdr-atom $list))
            )
            (if (< $pivot $head)
                ($head (find_largest $pivot $tail))
                (find_largest $pivot $tail)
            )
        )
    )
)

; !(find_largest 2 (2 4 3 1))

!(sort_list (2 4 3 1))
; !(extract (find_smallest 2 (2 3 4 1)))
; !(length (2 4 1 5 3))