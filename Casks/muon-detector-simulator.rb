cask "muon-detector-simulator" do
  version "1.0.0"
  sha256 "2fe6602f1e4ac309cc01f1f5d2552cdc0e4f037e41b91fa23666f9f7533a2076"

  url "https://github.com/sergiomtzlosa/muon-detector-simulator/releases/download/v#{version}/Muon.Detector.Simulator-#{version}-macos.zip"
  name "Muon Detector Simulator"
  desc "A three-tube cosmic-ray muon telescope"
  homepage "https://github.com/sergiomtzlosa/muon-detector-simulator"

  livecheck do
    url "https://github.com/sergiomtzlosa/muon-detector-simulator"
    strategy :github_latest
  end

  depends_on :macos

  app "Muon Detector Simulator.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Muon Detector Simulator.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/Muon Detector Simulator.app",
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
