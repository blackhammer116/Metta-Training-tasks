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

(: appendAtom (-> Atom Atom Atom))
(= (appendAtom $a $atom) (foldr cons-atom ($a) $atom))

; (= (reverse (nil))

; )
(= (reverse (cons $x $xs))
    (if (== $xs (nil))
        ((nil) cons $x)
        ((reverse $xs) cons $x)
    )
)

!(reverse (cons 1 (cons 2 (cons 3 (nil)))))
; !(car-atom (cons 3 (cons 2 (cons 1 (nil)))))

(= (length (nil)) 0 )
(= (length (cons $x $xs))
    (+ 1 (length $xs))
)

; !(length (cons 1 (cons 2 (cons 3 (cons 4 (nil))))))