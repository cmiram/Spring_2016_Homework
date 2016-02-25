# First target is default target, if you just type:  make

FILE=cache_sim.c

default: run

run: Cashe_Sim
	./cacheSim

Cashe_Sim: ${FILE}
	gcc -o cacheSim ${FILE}

# 'make' will view $v as variable and try to expand it.
# By typing $$, make will reduce it to a single '$' and pass it to the shell.
# The shell will view $dir as a variable and expand it.
dist:
	dir=`basename $$PWD`; tar cvf $$dir.tar ./$$dir; gzip $$dir.tar
	dir=`basename $$PWD`; ls -l ../$$dir.tar.gz
