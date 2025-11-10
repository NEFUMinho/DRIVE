
CC := gcc
CFLAGS := -Wall -Wextra -Wpedantic -g

BLD_DIR := build

CFILES = $(wildcard *.c)
OBJS = $(patsubst %.c, $(BLD_DIR)/%.o, $(CFILES))
BIN = grafos

.DEFAULT_GOAL := all

all: setup $(BIN)

$(BIN): $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@

$(BLD_DIR)/%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

setup:
	@mkdir -p $(BLD_DIR)

clean:
	rm -rf $(BLD_DIR)
	rm -f $(BIN)
