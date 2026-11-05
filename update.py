"""Update the formula from the latest stable public release."""
import json
import os
from pathlib import Path
import urllib.request


def fetch(url):
    request = urllib.request.Request(url, headers={"Accept": "application/vnd.github+json", "User-Agent": "trailmix-homebrew-tap"})
    token = os.environ.get("GH_TOKEN")
    if token and url.startswith("https://api.github.com/"):
        request.add_header("Authorization", "Bearer " + token)
    with urllib.request.urlopen(request) as response:
        return response.read().decode()


release = json.loads(fetch("https://api.github.com/repos/andrewmarous/trailmix/releases/latest"))
tag = release["tag_name"]
import re
if not re.fullmatch(r"v\d+\.\d+\.\d+", tag):
    raise ValueError("Expected a stable version tag")
version = tag[1:]
base = f"https://github.com/andrewmarous/trailmix/releases/download/{tag}"
checksums = {}
for line in fetch(base + "/checksums.txt").splitlines():
    digest, name = line.split()
    if not re.fullmatch(r"[0-9a-f]{64}", digest):
        raise ValueError("Invalid SHA256")
    checksums[name.removeprefix("./")] = digest

lines = [
    "class Trailmix < Formula",
    '  desc "Shared Markdown memory for AI agents"',
    '  homepage "https://github.com/andrewmarous/trailmix"',
    f'  version "{version}"',
    '  license "MIT"',
    "",
]
for system, goos in (("macos", "darwin"), ("linux", "linux")):
    lines.append(f"  on_{system} do")
    for cpu, arch in (("arm", "arm64"), ("intel", "amd64")):
        name = f"trailmix_{version}_{goos}_{arch}.tar.gz"
        lines.extend([
            f"    on_{cpu} do",
            f'      url "{base}/{name}"',
            f'      sha256 "{checksums[name]}"',
            "    end",
        ])
    lines.extend(["  end", ""])
lines.extend([
    "  def install",
    '    bin.install "tmix"',
    '    (share/"trailmix").install "skills"',
    "  end",
    "",
    "  test do",
    '    assert_match "tmix v#{version}", shell_output("#{bin}/tmix --version")',
    '    system bin/"tmix", "--vault", testpath/"vault", "init"',
    '    assert_path_exists testpath/"vault/inbox"',
    "  end",
    "end",
    "",
])
Path("Formula").mkdir(exist_ok=True)
Path("Formula/trailmix.rb").write_text("\n".join(lines))
print(f"Updated Trailmix to {tag}")
