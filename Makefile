compile:
	vcs -full64 +incdir+rtl+testbench -debug_access+all -kdb -lca -f design.f
run:compile
	./simv
verdi:run
	verdi -ssf test.fsdb -dbdir simv.daidir


.PHONY:clean
clean:
	rm -f simv
	rm -rf csrc/ simv.daidir/
