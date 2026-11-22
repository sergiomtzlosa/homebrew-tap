class SpaceVortex < Formula
  desc "Wireframe arcade shooter"
  homepage "https://github.com/sergiomtzlosa/space-vortex"
  version "1.0.0"
  url "https://github.com/sergiomtzlosa/space-vortex/releases/download/v1.0.0/space-vortex-1.0.0-macos-arm64.tar.gz"
  sha256 "3cdea5875168c21d9ec7d4ad6c61ef9e750da10ff2335a75c35094a4fee462f4"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "space_vortex"
  end
end
