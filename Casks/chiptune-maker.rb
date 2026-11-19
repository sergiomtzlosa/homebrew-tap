cask "chiptune-maker" do
  version "1.0.0"
  sha256 "82544e4ea83a29c5f95727664048598b38dd9ca4db527e82f61eed64dbddde97"

  url "https://github.com/sergiomtzlosa/chiptune-maker/releases/download/v#{version}/ChiptuneMaker-#{version}-macos.zip"
  name "Chiptune Maker"
  desc "A native macOS chiptune composer and tracker"
  homepage "https://github.com/sergiomtzlosa/chiptune-maker"

  livecheck do
    url "https://github.com/sergiomtzlosa/chiptune-maker"
    strategy :github_latest
  end

  depends_on :macos

  app "ChiptuneMaker.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/ChiptuneMaker.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/ChiptuneMaker.app",
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
