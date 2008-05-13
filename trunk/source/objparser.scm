(load "objimporter.scm")

(define 3d-data
  '((vertex-coord)
    (texture-coord)
    (normal-coord)))

(define (add-material)
  #f)

;; TODO: Check for less than 3 vertexes in the input file
(define (add-vertexes)
  (let ((vertex1 (lexer))
        (vertex2 (lexer))
        (vertex3 (lexer)))
    (list (car vertex1) (car vertex2) (car vertex3))))

(define (read-token-func function #!key eof-message (stop-predicate (lambda() #f)))
  (let loop()
    (let ((result (lexer)))
      (unless (or (eq? result 'eof) (stop-predicate))
        (begin
          (function result)
          (loop)))
      (if (eq? result 'eof)
          (error eof-message)))))

;; Creates the final object specification, reading from the face data
(define (assemble-object name vertex texture normal)
  (let ((vertex-array (list->vector vertex))
        (texture-array (list->vector texture))
        (normal-array (list->vector normal)))
    ;; Reader function here


(define (read-obj filename)
  (lexer-init 'port (open-input-file filename))
  (let ((vertex-data '())
        (texture-data '())
        (normal-data '())
        (object-name "")
        (objects-list '()))
    (read-token-func
     (lambda(token)
       (case token)
       ((vertex-coord) (cons vertex-data (add-vertexes)))
       ((texture-coord) (cons texture-data (add-vertexes)))
       ((normal-data) (cons normal-data (add-vertexes)))
       ((face) (cons (assemble-object object-name vertex-data texture-data normal-data) objects-list))
       ((mtllib) (add-material))
       (else (print token))))
    objects-list))

(read-obj "../assets/models/cube_Scene.obj")