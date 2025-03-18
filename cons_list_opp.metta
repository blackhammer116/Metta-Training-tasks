(: nil empty)
(: cons node)
; !(get-type nil)
; !(get-type cons)

; !(cons 1 (cons 2 (cons 3 (nil))))
; (= (foldl $func $x $null)
;     ($func $x $null)
; )
(= (foldl $func $null (cons $x $xs) )
    (if (== $xs (nil))
        ($func $x $null)
        (let*
            (
                ($n ($func $x (foldl $func $null $xs)))
            )
            $n
        )
    )
)

; !(foldl + 0 (cons 1 (cons 2 (cons 3 (nil)))))


(= (foldr $func $null (cons $x $xs))
   (if (== $xs (nil))
       ($func $x $null)
       (let $ft (foldr $func $null $xs) ($func $x $ft)
        )
    )
)

; !(foldr + 0 (cons 1 (cons 2 (cons 3 (nil)))))

;; helper functions for reverse list
(= (append_end $x (nil))
    (cons $x (nil))
)
(= (append_end $y (cons $x $xs))
    (if (== $xs (nil))
        (cons $x (cons $y (nil)))
        (cons $x (append_end $y $xs))
    )
)

; !(append_end (cons 1 (cons 2 (cons 3 (nil)))))


(= (reverse (cons $x $xs))
    (if (== $xs (nil))
        (append_end $x $xs)
        (append_end $x (reverse $xs))
    )
)

!(reverse (cons 1 (cons 2 (cons 3 (nil)))))

; !(car-atom (cons 3 (cons 2 (cons 1 (nil)))))

(= (length (nil)) 0 )
(= (length (cons $x $xs))
    (+ 1 (length $xs))
)

; !(length (cons 1 (cons 2 (cons 3 (cons 4 (nil))))))