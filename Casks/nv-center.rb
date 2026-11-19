cask "nv-center" do
  version "1.0.0"
  sha256 "538accf5aae619bf2017fde86c987dc0d4a823dc46adbed32d35bc28eada321c"

  url "https://github.com/sergiomtzlosa/nv-center/releases/download/v#{version}/NVSpinLab-#{version}-macos.zip"
  name "NV Spin Lab"
  desc "NV Spin Lab is a native macOS teaching application for nitrogen-vacancy (NV) center experiments in diamond"
  homepage "https://github.com/sergiomtzlosa/nv-center"

  livecheck do
    url "https://github.com/sergiomtzlosa/nv-center"
    strategy :github_latest
  end

  depends_on :macos

  app "NVSpinLab.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/NVSpinLab.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/NVSpinLab.app",
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
