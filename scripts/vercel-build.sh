#!/usr/bin/env bash
set -euo pipefail

# Vercel has no Flutter SDK. Clone a shallow stable copy for this build only.
FLUTTER_DIR="${PWD}/.vercel-flutter"
if [[ ! -x "${FLUTTER_DIR}/bin/flutter" ]]; then
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable "${FLUTTER_DIR}"
fi

export PATH="${FLUTTER_DIR}/bin:${PATH}"
flutter config --no-analytics --enable-web
flutter pub get
flutter build web --release --base-href /
