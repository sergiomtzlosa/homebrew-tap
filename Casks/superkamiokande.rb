cask "superkamiokande" do
  version "1.0.0"
  sha256 "71f2110c7c0f2b7603f6149b762d3c8b11465597f400f4eab0c82ef089aa4e35"

  url "https://github.com/sergiomtzlosa/superkamiokande/releases/download/v#{version}/SuperKamiokande-#{version}-macos.zip"
  name "SuperKamiokande"
  desc "Super-Kamiokande (Super-K) neutrino detector in 3D"
  homepage "https://github.com/sergiomtzlosa/superkamiokande"

  livecheck do
    url "https://github.com/sergiomtzlosa/superkamiokande"
    strategy :github_latest
  end

  depends_on :macos

  app "SuperKamiokande.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/SuperKamiokande.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/SuperKamiokande.app",
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
