cask "iss-tracker" do
  version "1.0.0"
  sha256 "01207cf4b6bf818e9f10f581d38795c1899e337cfed3afaca37cda878e8419a5"

  url "https://github.com/sergiomtzlosa/iss-tracker/releases/download/v#{version}/ISSTracker-#{version}-macos.zip"
  name "ISS Tracker"
  desc "A native macOS application that tracks the International Space Station"
  homepage "https://github.com/sergiomtzlosa/iss-tracker"

  livecheck do
    url "https://github.com/sergiomtzlosa/iss-tracker"
    strategy :github_latest
  end

  depends_on :macos

  app "ISSTracker.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/ISSTracker.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/ISSTracker.app",
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
