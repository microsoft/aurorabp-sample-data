#!/bin/bash
#
# Bash script to update the conda lock files for all supported platforms.
#
# Usage: update-conda-lock.sh
#
# Script should follow style guide: https://google.github.io/styleguide/shellguide.html

#############
# Constants #
#############

readonly ENV_FILE="environment.yml"
# Each platform name must be preceded by "-p".
readonly PLATFORMS_ARGS="-p linux-64 -p osx-64 -p osx-arm64 -p win-64"

#################
# Main Function #
#################

main() {
  # Check that conda command exists.
  if ! 2>/dev/null 1>/dev/null command -v "conda" ; then 
    echo "ERROR: conda command not found on PATH"
    exit 1
  fi

  # Install conda-lock if not found.
  if ! 2>/dev/null 1>/dev/null command -v "conda-lock" ; then 
    echo "Installing conda-lock..."
    if ! conda install --yes conda-forge::conda-lock ; then
      echo "ERROR: failed to install conda-lock"
      exit 1
    fi
  fi

  # Check that conda-lock command exists.
  if ! 2>/dev/null 1>/dev/null command -v "conda-lock" ; then 
    echo "ERROR: conda-lock command not found on PATH"
    exit 1
  fi

  # Generate unified conda lock file for all platforms (conda-lock.yml).
  echo "Generating conda lock file with locked environment dependencies (might take a while)..."
  # shellcheck disable=2086 # word splitting is desired
  if ! conda-lock lock --check-input-hash ${PLATFORMS_ARGS} -f "${ENV_FILE}" ; then 
    echo "ERROR: failed to resolve locked environments"
    exit 1
  fi

  # Generate explicit versions of the lock files for each supported platforms (conda-{platform}.lock).
  if ! 2>/dev/null 1>/dev/null conda-lock render -k explicit ; then 
    echo "ERROR: failed to render explicit lock files"
    exit 1
  fi

  echo "Successfully generated new conda lock files"
}

####################
# Top-Level Script #
####################

# Run main.
main "$@"
