cask "car-speedtrack" do
  version "1.0.0"
  sha256 "4834aee04c68c41ef86078966b97b5c4cde96a40a164ca5b7e7c2e2efb201e00"

  url "https://github.com/sergiomtzlosa/car-speedtrack/releases/download/v#{version}/CarSpeedtrack-#{version}-macos.zip"
  name "Car Speedtrack"
  desc "colourful, top-down pixel-art arcade road trip"
  homepage "https://github.com/sergiomtzlosa/car-speedtrack"

  livecheck do
    url "https://github.com/sergiomtzlosa/car-speedtrack"
    strategy :github_latest
  end

  depends_on :macos

  app "CarSpeedtrack.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/CarSpeedtrack.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/CarSpeedtrack.app",
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
