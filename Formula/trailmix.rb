class Trailmix < Formula
  desc "Shared Markdown memory for AI agents"
  homepage "https://github.com/andrewmarous/trailmix"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/andrewmarous/trailmix/releases/download/v0.2.1/trailmix_0.2.1_darwin_arm64.tar.gz"
      sha256 "f007e11a3251a106d0bf79a05c6685e487a05866989295595e178f8f2ee349ad"
    end
    on_intel do
      url "https://github.com/andrewmarous/trailmix/releases/download/v0.2.1/trailmix_0.2.1_darwin_amd64.tar.gz"
      sha256 "55a4617cd3a63ff3871eba200441d65d526834aa9db4ef6016a2b2db2a61d452"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/andrewmarous/trailmix/releases/download/v0.2.1/trailmix_0.2.1_linux_arm64.tar.gz"
      sha256 "dcfe2c30e886b5e15d22a64608e0cba51523551fb1f62511707097192503b6c9"
    end
    on_intel do
      url "https://github.com/andrewmarous/trailmix/releases/download/v0.2.1/trailmix_0.2.1_linux_amd64.tar.gz"
      sha256 "3b5833fa55abadd3f476edce5a66960c620e0fc2aad8a382bfcacb8f97f29000"
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
