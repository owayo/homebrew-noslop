class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.9.111/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "f54f21740ded40647f8be8ee429cdf1c0f4c81c1a433835c4cc57a7926b56e4f"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.9.111/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "e7e311cb1b1c206e6fb6b8125a49b023933bf79af35d8f2698903b0627ac030d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.9.111/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8f00b2f878284c2a8f5a8c5e022fe929849e1b6c490c391c392d54ce7819767c"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.9.111/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "70c0e84d50378168022ab7116ac4620a89cc28ec0ee9e7b1c36dd87394201ad3"
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
