class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.9.104/noslop-darwin-arm64"
      sha256 "518b1586cf16507074a7e3ff69d2b6125ae98689f3dfff8c529f72a10e4e8eed"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.9.104/noslop-darwin-amd64"
      sha256 "93d1fa723389edbdf6ac6fb75987793c60d68d6df1ff365f4f53170d2b5b5e8d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.9.104/noslop-linux-arm64"
      sha256 "1687bfe2d1e7ae5d1eadbbbd3b1f56b50f4cb8c4f35c6ad01f070bc141cbdc76"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.9.104/noslop-linux-amd64"
      sha256 "033b372599b24e9faec17e60f5186db0a26f8db50c75d842c1f2f4dd56dfdc17"
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
