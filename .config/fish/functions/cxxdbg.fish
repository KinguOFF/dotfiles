function cxxdbg --wraps='g++ -std=c++20 -g3 -O0 -fno-omit-frame-pointer -Wall -Wextra -Wpedantic' --description 'alias cxxdbg=g++ -std=c++20 -g3 -O0 -fno-omit-frame-pointer -Wall -Wextra -Wpedantic'
  g++ -std=c++20 -g3 -O0 -fno-omit-frame-pointer -Wall -Wextra -Wpedantic $argv
        
end
