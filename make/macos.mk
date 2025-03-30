install: install-homebrew

install-homebrew:
	@echo "Installing Homebrew..."
	@command -v brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
