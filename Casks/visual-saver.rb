cask "visual-saver" do
  version "1.0.0"
  sha256 "bd2a9923ccf8b1b93e47e9e779274bd6c6cfab38f0b34532883930553a543d3d"

  url "https://github.com/sergiomtzlosa/visual-saver/releases/download/v#{version}/VisualSaver-#{version}-macos.zip"
  name "Visual Saver"
  desc "A macOS utility that shows every screen saver this Mac knows about"
  homepage "https://github.com/sergiomtzlosa/visual-saver"

  livecheck do
    url "https://github.com/sergiomtzlosa/visual-saver"
    strategy :github_latest
  end

  depends_on :macos

  app "VisualSaver.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/VisualSaver.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/VisualSaver.app",
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
