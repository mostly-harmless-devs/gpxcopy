all: main

main: main.rkt
	raco exe main.rkt

clean: main
	rm -f main
