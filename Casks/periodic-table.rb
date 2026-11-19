cask "periodic-table" do
  version "1.0.0"
  sha256 "c574e50cca5188610d7a172fd722a2f1b84ba61c34afb06a9bb2a66a7940080d"

  url "https://github.com/sergiomtzlosa/periodic-table/releases/download/v#{version}/PeriodicTable-#{version}-macos.zip"
  name "Periodic Table"
  desc "A native macOS app for exploring all 118 chemical elements. Pick any element and the right-hand pane fills with its properties, uses and history, while a 3D model of a related molecule"
  homepage "https://github.com/sergiomtzlosa/periodic-table"

  livecheck do
    url "https://github.com/sergiomtzlosa/periodic-table"
    strategy :github_latest
  end

  depends_on :macos

  app "PeriodicTable.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/PeriodicTable.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/PeriodicTable.app",
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
