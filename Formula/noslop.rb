class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  version "26.9.103"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.9.103/noslop-darwin-arm64"
      sha256 "d8dfb1f5d49fe78daefda34e4e78120473cd412e4934cab56bfc16e60642aff2"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.9.103/noslop-darwin-amd64"
      sha256 "dff5470b37b04b3b300613ecb6660ebb1714b5247a312be56c488e32ff12c15e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/owayo/noslop/releases/download/v26.9.103/noslop-linux-amd64"
      sha256 "6b7a8b5d236424b3ba437b9c940409134ccde3c6a77e45ab88cbdaf5cb30bd0c"
    end
  end

  def install
    # リリースの添付は圧縮していないバイナリ (noslop-<OS>-<CPU>) なので、名前を noslop に直して入れる
    binary = Dir["noslop-*"].first
    chmod 0755, binary
    bin.install binary => "noslop"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/noslop --version")
    (testpath/"draft.md").write "まとめると、この方針が大切だと言えるでしょう。\n"
    output = shell_output("#{bin}/noslop check --no-config --format json draft.md")
    assert_match(/"ruleId":\s*"P01"/, output)
  end
end
