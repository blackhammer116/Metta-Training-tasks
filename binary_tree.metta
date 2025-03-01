; Future expansion: automate the node creation process

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


(= (update_tree $original $new)
    (let*
     (
        (() (remove-atom &self $original))
        ($updated (add-atom &self $new))
     )
     $updated
    )
)

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

(= (insert_binaryTree $parent $child)
    (let*
        (
            ($parentData  (getData $parent))
            ($childData   (getData $child))
            ($parentLeft  (getLeft $parent))
            ($parentRight (getRight $parent))
        )
        (if (< $parentData $childData)
            (if (== $parentLeft ())
                (let*
                    (
                        ($remove (Node_left (Node $parent) ()))
                        ($add (Node_left (Node $parent) $child))
                        ($updated (update_tree $remove $add))
                        ; (() (println! $updated))
                        ($checkLeft (getLeft $parent))
                        ; (() (println! $checkleft))
                    )
                    $checkLeft
                )
                (insert_binaryTree $parentLeft $child)
            )
            (if (== $parentRight ())
                (let*
                    (
                        ($remove (Node_right (Node $parent) ()))
                        ($add (Node_right (Node $parent) $child))
                        ($updated (update_tree $remove $add))
                        ; (() (println! $updated))
                        ($checkLeft (getLeft $parent))
                        ; (() (println! $checkleft))
                    )
                    $checkLeft
                )
                (insert_binaryTree $parentLeft $child)
            )
        )
    )
)

!(insert_binaryTree root child1)
!(getLeft root)