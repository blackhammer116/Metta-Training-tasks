(: nil empty)
(: cons node)
; !(get-type nil)
; !(get-type cons)

; !(cons 1 (cons 2 (cons 3 (nil))))
; (= (foldl $func $x $null)
;     ($func $x $null)
; )
(: foldl (-> $f $n $l $n))
(= (foldl $func $null (nil))
    ($func $null $null)
)
(= (foldl $func $null (cons $x $xs) )
    (let $n ($func $x (foldl $func $null $xs)) $n)
)

; !(foldl + 0 (cons 1 (cons 2 (cons 3 (nil)))))

(: foldl (-> $f $n $l $n))
(= (foldr $func $null (nil))
    ($func $null $null)
)
(= (foldr $func $null (cons $x $xs))
    (let $ft (foldr $func $null $xs) ($func $x $ft))
)

; !(foldr + 0 (cons 1 (cons 2 (cons 3 (nil)))))

;; helper functions for reverse list
(: append_end (-> $v $l $l))
(= (append_end $x (nil))
    (cons $x (nil))
)
(= (append_end $y (cons $x $xs))
    (cons $x (append_end $y $xs))
)

; !(append_end 0 (cons 1 (cons 2 (cons 3 (nil)))))

(: reverse (-> $l $l))
(= (reverse (cons $x $xs))
    (if (== $xs (nil))
        (append_end $x $xs)
        (append_end $x (reverse $xs))
    )
)

; !(reverse (cons 1 (cons 2 (cons 3 (nil)))))

(: length (-> $l Number))
(= (length (nil)) 0 )
(= (length (cons $x $xs))
    (+ 1 (length $xs))
)

!(length (cons 1 (cons 2 (cons 3 (cons 4 (nil))))))