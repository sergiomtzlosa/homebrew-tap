cask "lhc" do
  version "1.0.0"
  sha256 "eff562507ffa5f561a9f4a3805f4041373c733b6d100b2631bb33d8531693a6f"

  url "https://github.com/sergiomtzlosa/lhc/releases/download/v#{version}/LHC-#{version}-macos.zip"
  name "LHC Interactive"
  desc "Explore the Large Hadron Collider"
  homepage "https://github.com/sergiomtzlosa/lhc"

  livecheck do
    url "https://github.com/sergiomtzlosa/lhc"
    strategy :github_latest
  end

  depends_on :macos

  app "LHC.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/LHC.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/LHC.app",
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
