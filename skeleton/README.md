# Ruby skeleton

This directory contains a ruby skeleton which allows for diving into the code right away without having to set up the framework and testing infrastructure first.

It provides RSpec for the tests and Guard for running them automagically in the background whenever the code or tests were changed.

# Usage

1. Put your ruby files into `lib/`, e.g. `lib/board.rb`
2. Create an according test file in `spec/`, e.g. `spec/board_spec.rb`
3. require the spec helper in the test: `require_relative 'spec_helper'`
4. Restart guard to take note of the new files: `guard`

Now whenever one of the source or test files is stored the according tests will be run and you will be notified about the rest using system notifications.
