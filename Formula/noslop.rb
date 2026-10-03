class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.103/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "d5270ae972aed6f8b3f35608a6e6dfe939d851e500a63cee1e3c8c7d64ab1ae7"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.103/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "a53b11c8e2de3b63a6aa2ea26f3aeb9d67391ab0a1464e90482cff8205186ac2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.103/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b2a08c1c6628574fcb27559aa9277c6c21fb1c5ed8698427db789b0f442d8132"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.103/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "628001c9687548d38978b4746d1669e240bbb2c323deacdd037b6a8a7f2e9328"
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
