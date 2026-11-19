cask "dark-matter-detector" do
  version "1.0.0"
  sha256 "9f19a440399d67e6865182d10fed15f3cffd7fa6dc99a406fad8acd35838b416"

  url "https://github.com/sergiomtzlosa/dark-matter-detector/releases/download/v#{version}/DarkMatterDetector-#{version}-macos.zip"
  name "Dark Matter Detector Simulator"
  desc "A dual-phase liquid-xenon time projection chamber (TPC), inspired by the LZ and XENONnT dark-matter experiments"
  homepage "https://github.com/sergiomtzlosa/dark-matter-detector"

  livecheck do
    url "https://github.com/sergiomtzlosa/dark-matter-detector"
    strategy :github_latest
  end

  depends_on :macos

  app "DarkMatterDetector.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/DarkMatterDetector.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/DarkMatterDetector.app",
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
