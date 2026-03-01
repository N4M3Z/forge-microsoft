# forge-microsoft — skills, test, and lint

LIB_DIR = $(or $(FORGE_LIB),lib)

.PHONY: help install clean verify test lint check init

help:
	@echo "forge-microsoft targets:"
	@echo "  make install  Deploy skills (Claude, Gemini, Codex, OpenCode)"
	@echo "  make verify   Check skills deployed across all providers"
	@echo "  make clean    Remove previously installed skills"
	@echo "  make test     Run shell tests"
	@echo "  make lint     Schema + shell linting"
	@echo "  make check    Verify module structure"

init:
	@if [ ! -d $(LIB_DIR)/mk ]; then \
	  echo "Initializing forge-lib submodule..."; \
	  git submodule update --init $(LIB_DIR); \
	fi

ifneq ($(wildcard $(LIB_DIR)/mk/common.mk),)
  include $(LIB_DIR)/mk/common.mk
endif

ifneq ($(wildcard $(LIB_DIR)/mk/skills/install.mk),)
  include $(LIB_DIR)/mk/skills/install.mk
endif

ifneq ($(wildcard $(LIB_DIR)/mk/skills/verify.mk),)
  include $(LIB_DIR)/mk/skills/verify.mk
endif

ifneq ($(wildcard $(LIB_DIR)/mk/shell.mk),)
  include $(LIB_DIR)/mk/shell.mk
endif

ifneq ($(wildcard $(LIB_DIR)/mk/lint.mk),)
  include $(LIB_DIR)/mk/lint.mk
endif

install: install-skills
	@echo "Installation complete. Restart your session or reload skills."

clean: clean-skills

verify: verify-skills

lint: lint-schema lint-shell lint-docs lint-rules
