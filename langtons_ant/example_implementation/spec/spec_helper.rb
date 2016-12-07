$LOAD_PATH << "."

require 'byebug'

Dir["lib/*"].each { |f| puts f; require(f) }
