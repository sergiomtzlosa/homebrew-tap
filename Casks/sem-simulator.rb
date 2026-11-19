cask "sem-simulator" do
  version "1.0.0"
  sha256 "915b5037c5ce0b39ea963a4317cc8b4ca6e06c098ec5ef9c8cac0b9385be8c60"

  url "https://github.com/sergiomtzlosa/sem-simulator/releases/download/v#{version}/SEM.Simulator-#{version}-macos.zip"
  name "SEM Simulator"
  desc "A brand-free, late-1980s-style scanning electron microscope console simulator"
  homepage "https://github.com/sergiomtzlosa/sem-simulator"

  livecheck do
    url "https://github.com/sergiomtzlosa/sem-simulator"
    strategy :github_latest
  end

  depends_on :macos

  app "SEM Simulator.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/SEM Simulator.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/SEM Simulator.app",
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
