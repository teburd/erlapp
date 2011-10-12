#!/bin/sh
cd `dirname $0`
erl +P 1000000 -smp -sname myapp -setcookie myapp -pa $PWD/ebin $PWD/apps/*/ebin $PWD/deps/*/ebin +Ktrue +A32 +S8 -boot start_sasl -s myapp 
