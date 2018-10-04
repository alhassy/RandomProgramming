/*
 * Hello with C!
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main (int argc, char *argv[])
{
  printf("\nHello, world!\n");
  exit(0);
}

/* For Emacs:

(defun execute-in-eshell (cmd)
  (message "Look at the *eshell* buffer!")
  (with-current-buffer "*eshell*"
    (eshell-return-to-prompt)
    (insert cmd)
    (eshell-send-input)
    (other-window 1)
    (end-of-buffer)
  )  
)

*/

//// Alternate compile command :: (concat "NAME=" NAME " ; gcc  $NAME.c -o $NAME ; ./$NAME")

// Local Variables:
// eval: (setq-local NAME (file-name-sans-extension (buffer-name)))
// compile-command: (execute-in-eshell (concat "gcc  " NAME ".c -o " NAME "&& ./" NAME "; rm " NAME))
// end:
