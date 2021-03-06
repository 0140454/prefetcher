CFLAGS = -mavx2 --std gnu99 -O0 -Wall

GIT_HOOKS := .git/hooks/pre-commit
EXECUTABLE := naive_transpose \
			  sse_transpose sse_prefetch_transpose \
			  avx_transpose avx_prefetch_transpose

all: $(GIT_HOOKS) $(EXECUTABLE)

%_transpose: main.c
	$(CC) $(CFLAGS) -D$(subst _transpose,,$@) -o $@ main.c

test: $(EXECUTABLE)
	./naive_transpose
	./sse_transpose
	./sse_prefetch_transpose
	./avx_transpose
	./avx_prefetch_transpose

$(GIT_HOOKS):
	@scripts/install-git-hooks
	@echo

clean:
	$(RM) $(EXECUTABLE)
