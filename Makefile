Platform	= $(shell uname)
Targets		= \
	tools/bin/bonnie++ \
	tools/bin/fsrand.py tools/bin/cmptree.py \
	tools/bin/fsracer \
	tools/bin/fsstress \
	tools/bin/fstest \
	tools/bin/fsx \
	tools/bin/iozone

ifeq ($(Platform),Darwin)
iozone_tgt	= macosx
Targets		+= tools/bin/fstorture
else ifeq ($(Platform),Linux)
iozone_tgt	= linux
endif

all: tools $(Targets)

tools:
	mkdir -p tools/bin

tools/bin/bonnie++:
	cd bonnie++ && ./configure --prefix $(CURDIR)/tools
	make -C bonnie++
	cp bonnie++/bonnie++ $@
	git clean -dfx bonnie++

tools/bin/fsracer:
	cp fsracer/* $(@D)

tools/bin/fsrand.py:
	cp fsrand/fsrand.py $(@D)

tools/bin/cmptree.py:
	cp fsrand/cmptree.py $(@D)

tools/bin/fsstress:
	make -C fsstress
	cp fsstress/fsstress $@
	git clean -dfx fsstress

tools/bin/fstest:
	make -C fstest/fstest
	cp fstest/fstest/fstest $@
	git clean -dfx "$(shell cd fstest/fstest && pwd -P)"

tools/bin/fstorture:
	make -C fstools/src/fstorture
	cp fstools/src/fstorture/fstorture $@
	git clean -dfx fstools/src/fstorture

tools/bin/fsx:
	make -C fstools/src/fsx
	cp fstools/src/fsx/fsx $@
	git clean -dfx fstools/src/fsx

tools/bin/iozone:
	make -C iozone/src/current $(iozone_tgt)
	cp iozone/src/current/iozone $@
	git clean -dfx iozone/src/current
