cask "car-racing-championship" do
  version "1.0.0"
  sha256 "2549de38c3f5e7e5e4e2883d95210e88968ab26ace3f29cc5aa9c84063a53294"

  url "https://github.com/sergiomtzlosa/car-racing-championship/releases/download/v#{version}/ApexSlotRacing-#{version}-macos.zip"
  name "Apex Slot Racing"
  desc "3D slot-car championship"
  homepage "https://github.com/sergiomtzlosa/car-racing-championship"

  livecheck do
    url "https://github.com/sergiomtzlosa/car-racing-championship"
    strategy :github_latest
  end

  depends_on :macos

  app "ApexSlotRacing.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/ApexSlotRacing.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/ApexSlotRacing.app",
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
