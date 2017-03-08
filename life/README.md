# Conway's Game of Life

* https://en.wikipedia.org/wiki/Conway's_Game_of_Life

## Task

Write a program which runs the game of life. It should put out results to
stdout for display and to a numbered sequence of files with the file name
of something like `glider-001.pixels` when run on a base file of
`glider.pixels`. It should take the size of the frame from the base file.
It should write dead cells as `0` and living cells as `1`. The display
should be more user-friendly.

## Command line

The should be a command with the interface of

   `life <input_file> [number_of_iterations]`

If `number_of_iterations` is given it should write in a sequence of files
with the frame in the filename as described above. If it is not given it
should just output the iteration, wait for half a second and calculate
the next iteration until stopped by the user with `CTRL-c`.

Executable and other files should be in the `src` directory.

## Classes

There should be a main class `Life` in a file `life.rb` which has a `run`
method which takes two arguments, the file name of the base file and
optionally a number of iterations. It should then behave as required by
the command line.
