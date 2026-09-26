class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.9.110/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "aa73f710164b83062f64dcbc88b785b5743df2219b74a88ccdf968830ca94562"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.9.110/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "325d06ed1522470fe6634a33f31d1d9d5182d750d2f09e8692151b17c2d38ea9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.9.110/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a2156ec3d06ed0d14b174fdfd536e868699a4d2390694ba317e86f94cf0b4053"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.9.110/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4b44f87f7bf457a2ce5c64fe339b4d4183204baca71fcb293817c710e0e8d261"
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
