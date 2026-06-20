# Published under the GitHub account lezzetli-mozaik18.
# Welcome to the Handler protocol.

- DO NOT RELY ON IN INDUSTRIAL CASES

- This package contains a template script handler. It is meant for use as an instructor when one input can control a wide spectrum of behavior.
- The handler's only behavior is to provide a stable directory for a cluster of shell scripts. When it is ran, it checks the stability of it's own directory before running the requested script and passing any other input over to it. This embedded system provides a stable environment for possibilities and fallbacks.
- Here is how the handler works:

- 1) Take the inputs. If there are none, print an error.
- 2) Check if the directory which contains the scripts exist. If it does not, print an error.
- 3) Treat the first chunk of input as the target script. If it does not exist, print an error.
- 4) If the script does exist, run it immediately while handing over any other chunk of input.

- Example usage:

-   bash "/directory/directory/handler.18" "resort-to-advanced-method.sh" "quiet"

-   Makes stability checks.
-   Runs "/directory/directory/hdp18/resort-to-advanced-method.sh".
-   Passes the second input "quiet" to "resort-to-advanced-method.sh".

- For information on error codes, please visit "https://github.com/lezzetli-mozaik18/lezzetli-mozaik18/error%20codes.txt".
