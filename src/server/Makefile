SUBDIRS = common $(addsuffix /,$(shell find lib test -type d))

all: FORCE
	@mkdir -p ${SOCIAL_ROOT}/build/server/ && make -s -f ${SOCIAL_ROOT}/etc/server.make
	@for d in $(SUBDIRS); \
		do (mkdir -p ${SOCIAL_ROOT}/build/server/$$d && cd $$d && make -s); \
	done
	-@if [ -f ${SOCIAL_ROOT}/build/server/pid ]; \
		then kill `cat ${SOCIAL_ROOT}/build/server/pid`; \
	fi

clean:
	rm -rf ${SOCIAL_ROOT}/build/server

FORCE: