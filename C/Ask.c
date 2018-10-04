/*
 * Example program making use of command line arguments, and Y/N prompt.
 *
 * Example use: ./Ask hello there, old friend
 */

#include <stdio.h>
#include <stdlib.h>  // make use of exit(n)
#include <stdbool.h>

int main (int argc, char *argv[])
{

  printf("Invoke this program at the command line: Ask [Text] \n");
  printf("The \"Text\" is shown, then Y/y or N/n must be pressed\n");
  printf("Which yields an error code of 1 or 2, respectively.\n\n");

  // Print the arguments, [Text].
  for(int x=1; x != argc; x++)
    printf("%s\x20", argv[x]);

  printf("\n\n(Y or N)?\n");
  
  while(true)
    {
      char c = getchar();

      if (c == 'Y' || c == 'y')
	{
	  printf("Yes\n");
	  exit(1);
	}
      
      if (c == 'N' || c == 'n')
	{
	  printf("No\n");
	  exit(2);
	}
    }
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
