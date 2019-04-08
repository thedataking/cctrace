#!/usr/bin/env bash

. "$(dirname "$0")/common.sh"

echo "downloading and extracting lua"
curl -s http://www.lua.org/ftp/lua-5.3.5.tar.gz | tar xz

LUA_HOME="$WORK_DIR/lua-5.3.5"
NUM_PROCS=`nproc --all`

cd ${LUA_HOME}
intercept-build make linux -j${NUM_PROCS}
mv compile_commands.json compile_commands.intercept
make clean
${CCTRACE} make linux -j${NUM_PROCS}
mv compile_commands.json compile_commands.cctrace
${CCEQ} compile_commands.intercept compile_commands.cctrace