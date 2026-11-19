cask "rubik-solver" do
  version "1.0.0"
  sha256 "3641dac7b0cf4f9da08a8dd326c56a4048fe6b4d9d797305c048dcf73386de69"

  url "https://github.com/sergiomtzlosa/rubik-solver/releases/download/v#{version}/RubikSolver-#{version}-macos.zip"
  name "RubikSolver"
  desc "Rubik's Cube solver"
  homepage "https://github.com/sergiomtzlosa/rubik-solver"

  livecheck do
    url "https://github.com/sergiomtzlosa/rubik-solver"
    strategy :github_latest
  end

  depends_on :macos

  app "RubikSolver.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/RubikSolver.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/RubikSolver.app",
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
