# DIRS
BINDIR = bin
SRCDIR = c
BUILDDIR = build
# TARGET
TARGET = $(BINDIR)/uno
# EXTENSIONS
SRCEXT = c
HEADEREXT = h
# SOURCES LIST
SOURCES = $(shell find $(SRCDIR) -type f -name '*.$(SRCEXT)')
# OBJECTS
OBJS = $(patsubst $(SRCDIR)/%, $(BUILDDIR)/%, $(SOURCES:.$(SRCEXT)=.o))
# COMPILER
CC = gcc
# FOR CLEANING
RM = /bin/rm
# WARNING FLAG
WARN = -Wall
# DEBUG FLAGS
DEBUG = -g
# LINKING FLAGS
LFLAGS = $(DEBUG) $(WARN)
# COMPILATION FLAGS
CFLAGS = $(DEBUG) -c $(WARN)

# ----------------------
# ENTRIES
# ----------------------

main: $(TARGET)

# Main Version
$(TARGET): $(OBJS)
	@echo "Linking..."
	@echo " $(CC) $^ -o $(TARGET) $(LFLAGS)"; $(CC) $^ -o $(TARGET) $(LFLAGS)
$(BUILDDIR)/%.o: $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(BUILDDIR)
	@echo " $(CC) $(CFLAGS) $(INCFLAG) -o $@ $<"; $(CC) $(CFLAGS) $(INCFLAG) -o $@ $<

# DUMMY ENTRIES
clean:
	@echo "Cleaning..."
	@echo " $(RM) -r $(OBJS) $(TARGET)"; $(RM) -r $(OBJS) $(TARGET)

.PHONY: clean
