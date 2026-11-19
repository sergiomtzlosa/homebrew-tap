cask "quantum-lab" do
  version "1.0.0"
  sha256 "659fca1d192c7e983404cb0f3db7477b14532fae57cdc4450e13b7206444a849"

  url "https://github.com/sergiomtzlosa/quantum-lab/releases/download/v#{version}/QuantumLab-#{version}-macos.zip"
  name "QuantumLab"
  desc "An app for exploring two complementary pictures of quantum dynamics"
  homepage "https://github.com/sergiomtzlosa/quantum-lab"

  livecheck do
    url "https://github.com/sergiomtzlosa/quantum-lab"
    strategy :github_latest
  end

  depends_on :macos

  app "QuantumLab.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/QuantumLab.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/QuantumLab.app",
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
