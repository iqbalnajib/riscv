PRJ_HOME ?= $(PWD)
PRJ_NAME ?= $(shell basename $(PWD))
SIM_PATH ?= $(PRJ_HOME)

# TEST_NAME := set_baud_rate_test
# TEST_NAME += uart_interrupt_test
# TEST_NAME += uart_polling_test
# TEST_NAME += quick_reg_access_test
TEST_NAME += rx_errors_int_test

VCS_VDB = design.vdb
SIM_VDB = sim.vdb

CM_FLAG += -cm line+cond+fsm+tgl+branch+assert

VERDI_FLAG := -sverilog +v2k -f $(SIM_PATH)/filelist.f
# VERDI_FLAG += -ntb_opts uvm-1.2 +define+UVM_NO_DEPRECATED

VCS_FLAG := $(VERDI_FLAG) \
	-debug_access+all+dmptf -kdb -lca \
	-debug_region+cell+encrypt \
	-LDFLAGS -Wl,--no-as-needed
VCS_FLAG += -timescale=1ns/1ps
VCS_FLAG += $(CM_FLAG) -cm_dir $(VCS_VDB) 
# VCS_FLAG += -CC -lpython3.6m -CC -I/usr/include/python3.6m
# VCS_FLAG += -LDFLAGS -lpython3.6m

SIM_FLAG := +ntb_random_seed=0
# SIM_FLAG := +ntb_random_seed_automatic
SIM_FLAG += $(CM_FLAG) -cm_dir $(SIM_VDB) 
# SIM_FLAG += +fsdb+delta
# SIM_FLAG += -verdi
# SIM_FLAG += +UVM_PHASE_TRACE +UVM_OBJECTION_TRACE

.PHONY: all vcs sim cov wave clr

all: vcs sim

vcs:
	@vcs $(VCS_FLAG) -l compile.log

sim:
	@$(foreach item, $(TEST_NAME), ./simv $(SIM_FLAG) +UVM_TESTNAME=$(item) -l $(item).log;)

wave:
	@verdi $(VERDI_FLAG) &

cov:
	@urg -dir $(VCS_VDB) $(SIM_VDB) -dbname merge.vdb -format both
	@verdi -cov -covdir merge.vdb &

clr:
	@ls -A | grep -iv makefile | grep -v filelist.f | xargs rm -rf
