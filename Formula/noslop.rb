class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.106/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "725c719e69884d3267c905c944143d80ce01e011f2ee040a3fa8346f0cf74fc4"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.106/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "500c80762a8f9ba4893721680f12066313b81a7cc5122f13fd56cda0692ece27"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.106/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "181774756882c43d024e554c37eb6214ac7c1fa78d6d95076426869f160ee4ff"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.106/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "300e2ffc1692bf9d48cd8ee5ec20614c6615c5af0b474da24221660281441413"
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
