class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.11.101/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "101e92302b6ae660697593c62f9dcbeebac4aa7948fecd8e14b38c1f940fb87a"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.11.101/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "c3bab1b828cc2d1fc7255b8cf0b7d6e09971b1f94238d169ac02369cff2cb938"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.11.101/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "09369d16f97805c3512139f628f4d1aa47ff4132e852e6856e439214a1730a0d"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.11.101/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "46708920a648128a4e5d320e2f72d97a22980bfd992f02e6a86fde26f9f33386"
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
