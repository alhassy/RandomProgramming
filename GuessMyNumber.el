;; Begin REPL as follows:
;; (progn (save-buffer) (ielm) (insert "(load \"~/RandomProgramming/GuessMyNumber.el\")"))
;;
;; Chapter 2 of Land of Lisp
;; See http://hyperpolyglot.org/lisp for a syntax comparison of Common Lisp and ELisp, and others.
;;
;; https://stackoverflow.com/questions/398579/whats-the-best-way-to-learn-lisp

(setq *small* 1)
(setq *big* 100)

(defun guess-my-number ()
  "Produce average of globals *small* and *big*
   by an arithmetical shift to the left; i.e., dividing by 2."
  (ash (+ *small* *big*) -1)
)

(defun smaller ()
  "If user calls (smaller) then that means the result of (guess-my-number)
   is too big and so the upper bound is reduced to be the current guess."
  (setq *big* (guess-my-number))
  (guess-my-number)
)

(defun bigger ()
    "If user calls (bigger) then that means the result of (guess-my-number)
   is too small and so the lower bound is reduced to be the current guess."
  (setq *small* (guess-my-number))
  (guess-my-number)
)

(defun start-over ()
  "Restart the game."
  (setq *small* 1 *big* 100)
  (guess-my-number)
)

;; Example Session: I secretly choose 23 as my number and played,
;;
;; ELISP> (load "~/RandomProgramming/GuessMyNumber.el")
;; t
;; ELISP> (guess-my-number)
;; 50
;; ELISP> (smaller)
;; 25
;; ELISP> (smaller)
;; 13
;; ELISP> (bigger)
;; 19
;; ELISP> (bigger)
;; 22
;; ELISP> (bigger)
;; 23
