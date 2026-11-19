cask "bloch-sphere" do
  version "1.0.0"
  sha256 "ca2ba636f10145563aafa9fbc6aa3d863bccd9ab65c96cba7e95fd722669dd81"

  url "https://github.com/sergiomtzlosa/bloch-sphere/releases/download/v#{version}/BlochSphere-#{version}-macos.zip"
  name "Bloch Sphere"
  desc "A realistic Bloch sphere for mac"
  homepage "https://github.com/sergiomtzlosa/bloch-sphere"

  livecheck do
    url "https://github.com/sergiomtzlosa/bloch-sphere"
    strategy :github_latest
  end

  depends_on :macos

  app "BlochSphere.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/BlochSphere.app"],
        must_succeed: false

    run "/bin/sh",
        args: [
          "-c",
          'codesign --verify --deep --strict "$1" 2>/dev/null || ' \
          '{ codesign --force --deep --sign - "$1" && ' \
          'codesign --verify --deep --strict "$1"; }',
          "sh",
          "{{appdir}}/BlochSphere.app",
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
