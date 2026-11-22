class MatrixEffectTerm < Formula
  desc "Command-line tool from sergiomtzlosa/matrix-effect-term"
  homepage "https://github.com/sergiomtzlosa/matrix-effect-term"
  version "1.0.0"
  url "https://github.com/sergiomtzlosa/matrix-effect-term/releases/download/v1.0.0/matrix-1.0.0-macos-arm64.tar.gz"
  sha256 "41b6747985967d70112a8fa460947f468e4b500823daa3e50174e090fc78843a"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "matrix"
  end
end
