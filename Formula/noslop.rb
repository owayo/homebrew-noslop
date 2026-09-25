class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.9.105/noslop-darwin-arm64"
      sha256 "d38bd2a6048a371425c1d45a11115f4fe1838409a586e38b53d87319f08bba91"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.9.105/noslop-darwin-amd64"
      sha256 "599c635a803e06b414747919338a0c769ac1c3f9f3bdf8794ae2df71b902d675"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.9.105/noslop-linux-arm64"
      sha256 "ed3cb87a86b8d610efa95000570dae6074fb68ea96b2a6de94b345b1bf655ab2"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.9.105/noslop-linux-amd64"
      sha256 "53d8c6f83a6481029cecb57c297e438ae8aeeabc356a439e6cb9e40c12d323fd"
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
