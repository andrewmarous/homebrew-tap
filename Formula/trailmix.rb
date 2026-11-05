class Trailmix < Formula
  desc "Shared Markdown memory for AI agents"
  homepage "https://github.com/andrewmarous/trailmix"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/andrewmarous/trailmix/releases/download/v0.1.0/trailmix_0.1.0_darwin_arm64.tar.gz"
      sha256 "9aab84e35458ed9be6aacad2b08f2c48829b173d189013365712238e5d06244c"
    end
    on_intel do
      url "https://github.com/andrewmarous/trailmix/releases/download/v0.1.0/trailmix_0.1.0_darwin_amd64.tar.gz"
      sha256 "39a7ceb5f2d8fef336ad54126a6f350edee1a7b916d1526331be7f5e059cc1ec"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/andrewmarous/trailmix/releases/download/v0.1.0/trailmix_0.1.0_linux_arm64.tar.gz"
      sha256 "6d2c7a4eb7028ac72b333b573eba0b048b5ea0e5861eeee4da41ad47add3015a"
    end
    on_intel do
      url "https://github.com/andrewmarous/trailmix/releases/download/v0.1.0/trailmix_0.1.0_linux_amd64.tar.gz"
      sha256 "f5ad6670958b40a730870251ce708949ef99b56707ad0f2d9bd128806d1936cc"
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
