cask "programma101" do
  version "1.0.0"
  sha256 "9e7ba01d3d420c34dcb9c66b4ffe357f674d901e11744399b47be4838d91a674"

  url "https://github.com/sergiomtzlosa/programma101/releases/download/v#{version}/Programma101-#{version}-macos.zip"
  name "Programma101"
  desc "A native macOS emulator of the Olivetti Programma 101 (1965)"
  homepage "https://github.com/sergiomtzlosa/programma101"

  livecheck do
    url "https://github.com/sergiomtzlosa/programma101"
    strategy :github_latest
  end

  depends_on :macos

  app "Programma101.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Programma101.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/Programma101.app",
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
