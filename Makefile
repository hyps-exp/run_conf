# Makefile for param_db CLI tool

CXX := g++
CXXFLAGS := -std=c++17 -Wall -Wextra -I./src
LDFLAGS :=
SRC_DIR := src
OBJ_DIR := obj
BIN_DIR := bin
BIN := param_db_tool
DBFILE := run_conf.json

SOURCES := $(wildcard $(SRC_DIR)/*.cpp)
OBJECTS := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SOURCES))

.PHONY: all clean run

all: $(BIN_DIR)/$(BIN)

$(BIN_DIR)/$(BIN): $(OBJECTS) | $(BIN_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(OBJ_DIR):
	mkdir -p $@

$(BIN_DIR):
	mkdir -p $@

run:
	./$(BIN_DIR)/$(BIN) print 1

clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

