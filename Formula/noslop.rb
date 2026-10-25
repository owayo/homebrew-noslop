class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.112/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "9a35a49d59392fc12f275b4d4b53e05406b250e5c9f0ea6238ac881f540bdfc7"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.112/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "a69907daa0f3055899acfae19a0336701b8c2a09ebfbad319eda0f3bed1bb338"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.112/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b403abd62193e45340e6d264abf5326e7584313ae95788debe5480535c481a03"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.112/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1bb0ffd6160179b980d6ab7a01365d9043a610e5340a6498c5e5b76c4db8b9be"
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
