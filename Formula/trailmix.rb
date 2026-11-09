class Trailmix < Formula
  desc "Shared Markdown memory for AI agents"
  homepage "https://github.com/andrewmarous/trailmix"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/andrewmarous/trailmix/releases/download/v0.1.1/trailmix_0.1.1_darwin_arm64.tar.gz"
      sha256 "70d9f8ff5a7f5c45b3006ee80316ff4c2adc67044923e3aa460c438e3d862ce9"
    end
    on_intel do
      url "https://github.com/andrewmarous/trailmix/releases/download/v0.1.1/trailmix_0.1.1_darwin_amd64.tar.gz"
      sha256 "cb8cb3124896d87646a8f594ee0fe5c93a6afb1ace51527feee9bdacc0daeed8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/andrewmarous/trailmix/releases/download/v0.1.1/trailmix_0.1.1_linux_arm64.tar.gz"
      sha256 "932b3a24f208257511349646acd672fa47b59a3c335fa048bbf290c364a69e31"
    end
    on_intel do
      url "https://github.com/andrewmarous/trailmix/releases/download/v0.1.1/trailmix_0.1.1_linux_amd64.tar.gz"
      sha256 "26678267c38171ccb61b0065d49fb4f29174368bddbfd2cf32a5bd82735cc70e"
    end
  end

  def install
    bin.install "tmix"
    (share/"trailmix").install "skills"
  end

  test do
    assert_match "tmix v#{version}", shell_output("#{bin}/tmix --version")
    system bin/"tmix", "--vault", testpath/"vault", "init"
    assert_path_exists testpath/"vault/inbox"
  end
end
