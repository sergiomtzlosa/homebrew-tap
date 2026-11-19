cask "turing-enigma" do
  version "1.0.0"
  sha256 "b26baeb0e53f6cd61f8ee3000c60e5b31dd8a92a5bc3b5073d32ac803cca6673"

  url "https://github.com/sergiomtzlosa/turing-enigma/releases/download/v#{version}/Turing-Enigma-#{version}-macos.zip"
  name "Turing Enigma"
  desc "A native macOS application that simulates a historically accurate Enigma machine and the Turing–Welchman Bombe"
  homepage "https://github.com/sergiomtzlosa/turing-enigma"

  livecheck do
    url "https://github.com/sergiomtzlosa/turing-enigma"
    strategy :github_latest
  end

  depends_on :macos

  app "Turing Enigma.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Turing Enigma.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/Turing Enigma.app",
        ]
  end

  caveats <<~EOS
    This app is not notarized and may have a missing or invalid
    signature. Its quarantine attribute is removed and the app is
    ad-hoc signed automatically during installation, bypassing
    Gatekeeper's first-launch check for this app.

    Rewriting an invalid signature can mask tampering. Only install
    releases you trust and whose checksum you verified.

    Do not disable SIP or Gatekeeper globally.
  EOS
end
