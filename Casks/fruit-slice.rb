cask "fruit-slice" do
  version "1.0.0"
  sha256 "1e63c2613a591b9c14ac5b4a6c88e52b620115d6240180d4bccb27284821a781"

  url "https://github.com/sergiomtzlosa/fruit-slice/releases/download/v#{version}/FruitNinja-#{version}-macos.zip"
  name "Fruit Slice"
  desc "Slice the fruits like a ninja"
  homepage "https://github.com/sergiomtzlosa/fruit-slice"

  livecheck do
    url "https://github.com/sergiomtzlosa/fruit-slice"
    strategy :github_latest
  end

  depends_on :macos

  app "FruitNinja.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/FruitNinja.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/FruitNinja.app",
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
