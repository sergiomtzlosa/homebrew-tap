cask "toybox" do
  version "1.0.0"
  sha256 "c17f631b2b0ac04395ca549ed17732b0d00a5c7f45610b28399c74fd031a1018"

  url "https://github.com/sergiomtzlosa/toybox/releases/download/v#{version}/Toybox-#{version}-macos.zip"
  name "Toybox"
  desc "An Otamatone and a rubber chicken synthesized"
  homepage "https://github.com/sergiomtzlosa/toybox"

  livecheck do
    url "https://github.com/sergiomtzlosa/toybox"
    strategy :github_latest
  end

  depends_on :macos

  app "Toybox.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Toybox.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/Toybox.app",
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
