class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.9.107/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "5caead6b1bc847ca55dc5ece1b7a95d8d254bd9d3ce721e3d798505335f8d3cb"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.9.107/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "8c4cc8fb1ca5eea599eafe16b9a52b24b4d7263b6e56d199df0d97bc023e680b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.9.107/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8d75ec9ae1b1730a7dc4b0a3b49a0cd38c6c5ba953b3ea977ad5969e8aad0ad6"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.9.107/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "654a1bf399221edf70910852caad0c2966018611fe3eccddc414253d65b9f33f"
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
