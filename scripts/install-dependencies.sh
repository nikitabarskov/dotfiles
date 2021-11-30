python -m pip install -qqq pip-tools=="$1" &&
  pip-compile --quiet --generate-hashes "$2" --output-file "$3"
