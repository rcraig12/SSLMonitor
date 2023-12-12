# Detect the OS and Machine Architecture
UNAME_S := $(shell uname -s)
UNAME_M := $(shell uname -m)

# Build directories
OUT_DIR_LINUX := ./bin/linux
OUT_DIR_WINDOWS := ./bin/windows
OUT_DIR_MAC_INTEL := ./bin/mac_intel
OUT_DIR_MAC_ARM := ./bin/mac_arm

# Conditional OS specific logic
ifeq ($(UNAME_S),Linux)
    build:
	    @mkdir -p $(OUT_DIR_LINUX)
	    @go build -o $(OUT_DIR_LINUX)/SSLMonitor
    run: build
	    @$(OUT_DIR_LINUX)/SSLMonitor
endif

ifeq ($(OS),Windows_NT)
    build:
	    @mkdir -p $(OUT_DIR_WINDOWS)
	    @go build -o $(OUT_DIR_WINDOWS)/SSLMonitor.exe
    run: build
	    @$(OUT_DIR_WINDOWS)/SSLMonitor.exe
endif

ifeq ($(UNAME_S),Darwin)
    ifeq ($(UNAME_M),x86_64)
        build:
	        @mkdir -p $(OUT_DIR_MAC_INTEL)
	        @GOARCH=amd64 go build -o $(OUT_DIR_MAC_INTEL)/SSLMonitor
        run: build
	        @$(OUT_DIR_MAC_INTEL)/SSLMonitor
    endif
    ifeq ($(UNAME_M),arm64)
        build:
	        @mkdir -p $(OUT_DIR_MAC_ARM)
	        @GOARCH=arm64 go build -o $(OUT_DIR_MAC_ARM)/SSLMonitor
        run: build
	        @$(OUT_DIR_MAC_ARM)/SSLMonitor
    endif
endif

# Default target
all: build

# If you want to add a target to build for all platforms regardless of the current OS
build_all:
	@mkdir -p $(OUT_DIR_LINUX) $(OUT_DIR_WINDOWS) $(OUT_DIR_MAC_INTEL) $(OUT_DIR_MAC_ARM)
	@go build -o $(OUT_DIR_LINUX)/SSLMonitor
	@GOOS=windows GOARCH=amd64 go build -o $(OUT_DIR_WINDOWS)/SSLMonitor.exe
	@GOOS=darwin GOARCH=amd64 go build -o $(OUT_DIR_MAC_INTEL)/SSLMonitor
	@GOOS=darwin GOARCH=arm64 go build -o $(OUT_DIR_MAC_ARM)/SSLMonitor
