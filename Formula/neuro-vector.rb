class NeuroVector < Formula
  desc "Command-line tool from sergiomtzlosa/neuro-vector"
  homepage "https://github.com/sergiomtzlosa/neuro-vector"
  url "https://github.com/sergiomtzlosa/neuro-vector/releases/download/v1.0.0/neuro-vector-v1.0.0-macos-arm64.zip"
  version "1.0.0"
  sha256 "1614a525fb4a2942e8b942646fa0fbc1287f119c0dedcd45ba62c614999a7f3a"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "neuro-vector-v1.0.0-macos-arm64/neuro-vector"
  end
end
