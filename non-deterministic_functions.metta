;; Helper functions
;;

(= (NotEq $x $y) (if (not (== $x $y)) $y (empty)))

(= (Eq $x $y $z) (if (== $x $y) $z $y))

(= (addTwo $x $y) (+ $x $y))

(= (isEven $x)  (if (== (% $x 2) 0) True False))

(= (isGrounded $x) (if (== (get-metatype $x) Grounded) True False))


;; Non-determinism functions
(: List Expression)

;; findAndRemove: finds a given Atom and removes it from the list (tuple) 
; (: findAndRemove (-> Atom ))
(= (findAndRemove $x $list)
    (collapse (NotEq $x (superpose $list)))
)

; !(findAndRemove 2 (1 2 3))

;; findAndReplace: finds an item from the list and replaces it with the
;; newly desired item
(= (findAndReplace $x $y $list)
    (collapse (Eq $x (superpose $list) $y))
)

; !(findAndReplace 2 5 (1 2 3))

;; map: maps a given function and an accumilator on a given list
(: map (-> (-> Atom Atom) Atom List List))
(= (map $func $acc $list)
    (collapse ($func $acc (superpose $list)))
)

; !(map addTwo 1 (1 2 3))

;; filter
(: filter (-> (-> Atom Atom) List List))
(= (filter $func $list)
   (collapse (let*
        (
            ($s (superpose $list))
            ($r (if (== ($func $s) True) $s (empty)))
        )
        $r
    ))
)

; !(filter isEven (1 2 3 4 5 6 7 8))

;; flatten
(= (flatten ()) (empty))
(= (flatten ($x $xs))
    (let*
        (
            ($y (if (== $xs ()) () (flatten $xs)))
        )
        (cons-atom $x $y)
    )
)
!(flatten (1 (2 (3 (4 ())))))
