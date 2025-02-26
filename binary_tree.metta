; **TODO**:
; create a node with left, right and data property
; define their types

; **Done**:



; (= (create_node ($name ($data ($left $right))))
;         (
;             (node $name)
;             (node_data (node $name) $data)
;             (node_left (node $name) $left)
;             (node_right (node $name) $right)
;         )
; )

(Node root)
(Node_data  (Node root) 2)
(Node_left  (Node root) ())
(Node_right (Node root) ())

(Node child1)
(Node_data  (Node child1) 3)
(Node_left  (Node child1) ())
(Node_right (Node child1) ())

(Node child2)
(Node_data  (Node child2) 1)
(Node_left  (Node child2) ())
(Node_right (Node child2) ())


(= (getData $node)
    (match &self
        (Node_data (Node $node) $data)
        $data
    )
)
(= (getLeft $node)
    (match &self
        (Node_left (Node $node) $left)
        $left
    )
)

(= (getRight $node)
    (match &self
        (Node_right (Node $node) $right)
        $right
    )
)
; !(add-atom &self (Node_left (Node root) (Node child1)))
; !(getLeft root)

(= (insert_binaryTree $parent $child)
    (let*
        (
            ($parentData  (getData $parent))
            ($childData   (getData $child))
            ($parentLeft  (getLeft $parent))
            ($parentRight (getRight $parent))
            ; ($parentNode  (getNode $parent))
            ; ($childNode   (getNode $parent))
        )
        (if (< $parentData $childData)
            (if (== $parentLeft ())
                ($parentLeft $child)
                (insert_binaryTree $parentLeft $child)
            )
            (if (== $parentRight ())
                (Node_right (Node $parent) $child)
                (insert_binaryTree $parentLeft $child)
            )
        )
    )
)



; !(Bt_node_expr 2 () ())
; !(create_node (root (2 (() ()))))
; !(create_node (child (5 (() ()))))
!(insert_binaryTree root child1)
!(getLeft root)
; !(insert_binaryTree 2 4)
; !(insert_binaryTree 4 1)
; !(insert_binaryTree 3 5)
; !(insert_binaryTree 5 1)