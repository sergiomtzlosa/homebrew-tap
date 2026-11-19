cask "fib-sem-simulator" do
  version "1.0.0"
  sha256 "5f69b0b493e6acb83975844af9ad323cc5ddcfdbd1305048e181db03216e4b27"

  url "https://github.com/sergiomtzlosa/fib-sem-simulator/releases/download/v#{version}/DualBeam.Lab-#{version}-macos.zip"
  name "DualBeam Lab"
  desc "A FIB/SEM training simulator"
  homepage "https://github.com/sergiomtzlosa/fib-sem-simulator"

  livecheck do
    url "https://github.com/sergiomtzlosa/fib-sem-simulator"
    strategy :github_latest
  end

  depends_on :macos

  app "DualBeam Lab.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/DualBeam Lab.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/DualBeam Lab.app",
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
