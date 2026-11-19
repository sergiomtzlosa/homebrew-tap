cask "new-file-creation-2" do
  version "1.0.0"
  sha256 "9db4060e6a4876cd1e11e337a641472c93558fa16814a31d59ffcce30bdd36fe"

  url "https://github.com/sergiomtzlosa/New-File-Creation-2/releases/download/v#{version}/New.File.Creation.2-#{version}-macos.zip"
  name "New File Creation 2"
  desc "Create files from templates in Finder, from the menu bar, from a template library, or with the nfc command-line tool"
  homepage "https://github.com/sergiomtzlosa/New-File-Creation-2"

  livecheck do
    url "https://github.com/sergiomtzlosa/New-File-Creation-2"
    strategy :github_latest
  end

  depends_on :macos

  app "New File Creation 2.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/New File Creation 2.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/New File Creation 2.app",
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
