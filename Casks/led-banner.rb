cask "led-banner" do
  version "1.0.0"
  sha256 "e3f97d13fea06d8aa750c076868f965dde36aa62598cf35d3afcc5a77e60a425"

  url "https://github.com/sergiomtzlosa/led-banner/releases/download/v#{version}/LED.Banner-#{version}-macos.zip"
  name "LED Banner"
  desc "Native macOS app that renders scrolling text on a simulated LED matrix"
  homepage "https://github.com/sergiomtzlosa/led-banner"

  livecheck do
    url "https://github.com/sergiomtzlosa/led-banner"
    strategy :github_latest
  end

  depends_on :macos

  app "LED Banner.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/LED Banner.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/LED Banner.app",
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
