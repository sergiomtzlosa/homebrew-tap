cask "drinking-bird" do
  version "1.0.0"
  sha256 "d233d6657477ebcac76d2cf3fc720199cc9599972debcfa9a281bfde04893ae6"

  url "https://github.com/sergiomtzlosa/drinking-bird/releases/download/v#{version}/DrinkingBird-#{version}-macos.zip"
  name "Drinking Bird"
  desc "A native macOS app that simulates the classic drinking bird (dippy bird) heat engine"
  homepage "https://github.com/sergiomtzlosa/drinking-bird"

  livecheck do
    url "https://github.com/sergiomtzlosa/drinking-bird"
    strategy :github_latest
  end

  depends_on :macos

  app "DrinkingBird.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/DrinkingBird.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/DrinkingBird.app",
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
