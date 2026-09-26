class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.9.106/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "6236989156162160b05ceaceead1432569a99a382b237d48e1dd2a3f3c4e5369"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.9.106/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "d409ce4e69ff9435cea7a6c5983ae6859e661f1ecf4e8dbde9683f01a4e702ff"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.9.106/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "67f472b8eac4b9ec523d19ecb9594020b1ffc7e18c82a2afd1d5dbf24cf93f48"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.9.106/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "32815966c479d7d1770183933925c0b91c253db1e340591bcf34558cfc0e4199"
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
