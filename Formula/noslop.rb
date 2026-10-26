class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.113/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "2e004e50305113b66d371fabc949e541204b94ebdbf802393d94721574df8816"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.113/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "1400792540faa695372fd2085d9db3a7d6fe71302d3034b20c0988bb216e1695"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.113/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b491eabfc4e1819f459737d0d437c761090aed894036c4b9e11641c5aa37b20d"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.113/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5822040173c74ac062840b4a9d5bde203068eca6e0a6a4794713173dea53115c"
    end
  end

  def install
    bin.install "noslop"
    # LICENSE は Homebrew が自動で入れる。同梱の辞書と文法の表示は名前が決まった形でないので明示する
    prefix.install "THIRD_PARTY_NOTICES.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/noslop --version")
    (testpath/"draft.md").write "まとめると、この方針が大切だと言えるでしょう。\n"
    output = shell_output("#{bin}/noslop check --no-config --format json draft.md")
    assert_match(/"ruleId":\s*"P01"/, output)
  end
end
