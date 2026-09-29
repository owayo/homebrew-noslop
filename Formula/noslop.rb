class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.9.113/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "c47f8ab7f06a8201dab96e34b3f3d293923391a6757a7f9074d6e7d4a18f8e90"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.9.113/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "3a6a88ca151868d0d6ed4002595ee1a06722823acc0b2d6424b0144e4e5c08c0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.9.113/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a5d4b81925818bd736264cd1a97004f7aacf9a5579d20447f5352095c97bbfdb"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.9.113/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "929a3726b0c30b19955be67df32e0b31ce8013e34ed8a6932271660655af1769"
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
