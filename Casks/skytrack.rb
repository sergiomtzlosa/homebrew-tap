cask "skytrack" do
  version "1.0.0"
  sha256 "59a16586fbc2fc06e85b90b88d0866454f44d40c0c2f6983713faac2a1cdf39a"

  url "https://github.com/sergiomtzlosa/skytrack/releases/download/v#{version}/SkyTrack-#{version}-macos.zip"
  name "SkyTrack"
  desc "SkyTrack is a native macOS planetarium"
  homepage "https://github.com/sergiomtzlosa/skytrack"

  livecheck do
    url "https://github.com/sergiomtzlosa/skytrack"
    strategy :github_latest
  end

  depends_on :macos

  app "SkyTrack.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/SkyTrack.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/SkyTrack.app",
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
