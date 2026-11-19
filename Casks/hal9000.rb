cask "hal9000" do
  version "1.0.0"
  sha256 "da08fa9ecc084d342ea624d8d356f72974781ea57a3fcde7ebaac8c44024c6da"

  url "https://github.com/sergiomtzlosa/hal9000/releases/download/v#{version}/HAL9000-#{version}-macos.zip"
  name "HAL 9000"
  desc "HAL9000 is a fan-made desktop experience"
  homepage "https://github.com/sergiomtzlosa/hal9000"

  livecheck do
    url "https://github.com/sergiomtzlosa/hal9000"
    strategy :github_latest
  end

  depends_on :macos

  app "HAL9000.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/HAL9000.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/HAL9000.app",
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
