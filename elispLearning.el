;; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.


;; C-x C-e  ◈  Show result in minibuffer; works in any mode.
;; C-j      ◈  Insert result onto new line in exisiting buffer; works in Lisp Interaction mode.

;; (+ 3 (+ 1 2))
;; (equal 5e-3 (/ 5.0 1000))

;; `setq' stores a value into a variable:
;; (setq my-name "Bastien")

;; Now switch to a new buffer named "*test*" in another window:
;; (switch-to-buffer-other-window "*test*")
;; `C-x C-e'
;; => [screen has two windows and cursor is in the *test* buffer]

;; Some function are interactive:
;; (read-from-minibuffer "Enter your name: ")
;; Evaluating this function returns what you entered at the prompt.

;; If you want to know more about a variable or a function:
;;
;; C-h v a-variable RET
;; C-h f a-function RET
;;
;; To read the Emacs Lisp manual with Emacs:
;;
;; C-h i m elisp RET

;; Booleans
;; In Emacs Lisp, nil is the only false value; everything else evalutes to true in a boolean context, including empty strings, zero, the symbol 'false, and empty vectors. An empty list, '(), is the same thing as nil.

;; QuasiQuote
;; `(1 ,(+ 1 1) 3)  ==>  (1 2 3) via a template system called "backquote"


;; Progn
;; If you need multiple expressions (statements) in the then-expr, you wrap them with a call to progn, which is like curly-braces in C or Java:


;;; COND

Elisp has two versions of the classic switch statement: cond and case.

Elisp does not have a table-lookup optimization for switch, so cond and case are just syntax for nested if-then-else clauses. However, if you have more than one level of nesting, it looks a lot nicer than if expressions. The syntax is:
(cond
  (test-1
    do-stuff-1)
  (test-2
    do-stuff-2)
  ...
  (t
    do-default-stuff))

The do-stuff parts can be any number of statements, and don't need to be wrapped with a progn block.

;; WHILE

hile

Elisp has a relatively normal while function: (while test body-forms)

Example, which you can evaluate in your *scratch* buffer:
(setq x 10
      total 0)
(while (plusp x)  ; while x is positive
  (incf total x)  ; add x to total
  (decf x))       ; subtract 1 from x

First we set two global variables, x=10 and total=0, then run the loop. Then we can evaluate the expression total to see that its value is 55 (the sum of the numbers 1 to 10).

;; Lables and Jumps and control transfer
;;
;; (catch 'label body) ◈ "body" contains a "(throw 'label valueHere)" clause that takes us to just after the "catch" call
;; thereby ignoring all commands that follow the "throw".
;;
;; Lisp has a facility for upward control-flow transfers called catch/throw. It's very similar to Java or C++ exception handling, albeit possibly somewhat lighter-weight.

;; To do a break from inside a loop in elisp, you put a (catch 'break ...) outside the loop, and a (throw 'break value) wherever you want to break inside the loop, like so:

;;  sum the numbers from 1 to 99 that are not evenly divisible by 5 
(setq x 0 total 0)
(catch 'break
  (while t
    (catch 'continue
      (incf x)
      (cond ((zerop (% x 5)) (throw 'continue nil) )
            ((>= x 100)      (throw 'break nil))
      )
      (incf total x)
    )
  )
)


;;; general loops
Pretty much all iteration in Emacs Lisp is easiest using the loop macro from the Common Lisp package. Just do this to enable loop:
(require 'cl)  ; get lots of Common Lisp goodies

The loop macro is a powerful minilanguage with lots of features, and it's worth reading up on. I'll use it in this primer to show you how to do basic looping constructs from other languages.

(loop for i in '(1 2 3 4 5 6)
      collect (* i i))           ; yields (1 4 9 16 25 36)

MA: Learn by producing GCL-style do-loops ;-)

#+BEGIN_EXPORT html
<div class="codeblock"><pre class='sh_lisp' style="overflow: visible">
(set 'fname "Mitch")
</pre></div>

or

Example:
<div class="codeblock"><pre class="sh_lisp" style="overflow: visible">
(setq testme nil)
(if testme
(setq a "1")
(setq a "3")
(setq a "2")
)
(message a)
</pre></div>

#+END_EXPORT

