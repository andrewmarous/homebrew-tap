class Trailmix < Formula
  desc "Shared Markdown memory for AI agents"
  homepage "https://github.com/andrewmarous/trailmix"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/andrewmarous/trailmix/releases/download/v0.2.0/trailmix_0.2.0_darwin_arm64.tar.gz"
      sha256 "ad7ce743ddcdb5ed15de33e4520ed2568e769268ae681dcee1b297ea13c8c576"
    end
    on_intel do
      url "https://github.com/andrewmarous/trailmix/releases/download/v0.2.0/trailmix_0.2.0_darwin_amd64.tar.gz"
      sha256 "0b6738c528cfaa52043a68aa1144318605b418d01413136800b32cbce5b5ab72"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/andrewmarous/trailmix/releases/download/v0.2.0/trailmix_0.2.0_linux_arm64.tar.gz"
      sha256 "ecde893dbfca0f45f36ece73e0e2b93626df36693718093ba95f93bd59169457"
    end
    on_intel do
      url "https://github.com/andrewmarous/trailmix/releases/download/v0.2.0/trailmix_0.2.0_linux_amd64.tar.gz"
      sha256 "aff6d5fa3eada0a272bf646d16492ba8fa42516f80148a21e2c930d9a4996c25"
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
