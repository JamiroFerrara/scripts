rm build
cmake -G "Visual Studio 16 2019" -A Win32 -S . -B "build\32bit" -DCMAKE_BUILD_TYPE=Release
cmake --build build\32bit --config Release
dwm
