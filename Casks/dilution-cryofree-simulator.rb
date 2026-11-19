cask "dilution-cryofree-simulator" do
  version "1.0.0"
  sha256 "f647e35ebb10284779e32d41ede70f63a20851c424aaf1b5b70fd03f5cd6be83"

  url "https://github.com/sergiomtzlosa/dilution-cryofree-simulator/releases/download/v#{version}/DilutionCryofreeSimulator-#{version}-macos.zip"
  name "Dilution Cryofree Simulator"
  desc "A native macOS application for exploring a modern cryogen-free dilution refrigerator"
  homepage "https://github.com/sergiomtzlosa/dilution-cryofree-simulator"

  livecheck do
    url "https://github.com/sergiomtzlosa/dilution-cryofree-simulator"
    strategy :github_latest
  end

  depends_on :macos

  app "DilutionCryofreeSimulator.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/DilutionCryofreeSimulator.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/DilutionCryofreeSimulator.app",
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
