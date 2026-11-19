cask "double-slit-experiment-simulator" do
  version "1.0.0"
  sha256 "bc464003db45e8ea0cffa6436ec4509059f17ea6a9d8d89edd7e12a9ffb8b652"

  url "https://github.com/sergiomtzlosa/double-slit-experiment-simulator/releases/download/v#{version}/DoubleSlitLab-#{version}-macos.zip"
  name "Double-Slit Lab"
  desc "Simulator for the classic Young's double-slit"
  homepage "https://github.com/sergiomtzlosa/double-slit-experiment-simulator"

  livecheck do
    url "https://github.com/sergiomtzlosa/double-slit-experiment-simulator"
    strategy :github_latest
  end

  depends_on :macos

  app "DoubleSlitLab.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/DoubleSlitLab.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/DoubleSlitLab.app",
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
