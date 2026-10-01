class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.100/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "2e5f55ff386b8bd01af5629b19a3caf4d37297def02f5bd978f42be1807c588d"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.100/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "a7db939c7e49c47d5bbc40645e1c77aa19bbcd08acc43388b0f79d90a706170d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.100/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "43939a3c81dfa849c4c7469d201583282b51cda81b99a81244f2616f34e43048"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.100/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e8a4743a8f4247c979cb053b65906ba86bee083f75308c6985af4cecdfe8a0b3"
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
