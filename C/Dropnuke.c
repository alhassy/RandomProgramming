/*
 * Drop 14 bombs, 💣, with 1 second delays;
 * after user presses enter.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define BOTTOM_ROW 14
#define BOMB "💣"

void pause(int seconds)
{
  clock_t done = seconds + clock();
  while( done > clock() )
    ;
}

int main ()
{
  printf("\033[2J"); // Clear screen, in a real terminal.
  printf("\nPress Enter to drop nuclear weapon: ");
  int _ = getchar();

  // Loop to drop bomb on the city, slowly.
  for(int drop=0; drop < BOTTOM_ROW; drop++)
    {
      printf("\n%s", BOMB);
      pause(1000*100);
    }

  printf(" BOOM!!!%s\n\n", BOMB);
  exit(0);
}

/* For Emacs:

(defun execute-in-eshell (cmd)
(with-current-buffer "*eshell*"
  (eshell-return-to-prompt)
  (insert cmd)
  (eshell-send-input)
  (other-window 1)
  (end-of-buffer)
)
)

*/

// Local Variables:
// eval: (setq-local NAME (file-name-sans-extension (buffer-name)))
// compile-command: (execute-in-eshell (concat "gcc  " NAME ".c -o " NAME "; ./" NAME))
// end:
