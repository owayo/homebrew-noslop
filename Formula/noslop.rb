class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.107/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "696cb33222d516791d8f36ad82788e9d6cc877334a55d88e6b31412e715e1ea3"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.107/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "f67e07fac941e188f8c0669c56698082bf20228ae1b6fa60af8a5c9debb527db"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.107/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "14478b6cb026535f587aad2c4656d043a5434d00945f412f7c39b76ffd45a84f"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.107/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f125d8cde539204c8725fbb9a1050f491e2d52570f8aaa8b42cf866b6a7fd8f4"
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
