obj-m := galcore.o

SRC := $(shell pwd)

all:
	$(MAKE) -C $(KERNEL_SRC) M=$(SRC)/kernel-module-imx-gpu-viv-src AQROOT=${PWD}/kernel-module-imx-gpu-viv-src
	cp $(SRC)/kernel-module-imx-gpu-viv-src/Module.symvers $(PWD)
	cp $(SRC)/kernel-module-imx-gpu-viv-src/modules.order $(PWD)

modules_install:
	$(MAKE) -C $(KERNEL_SRC) M=$(SRC)/kernel-module-imx-gpu-viv-src modules_install

clean:
	rm -f *.o *~ core .depend .*.cmd *.ko *.mod.c
	rm -f Module.markers Module.symvers modules.order
	rm -rf .tmp_versions Modules.symvers
