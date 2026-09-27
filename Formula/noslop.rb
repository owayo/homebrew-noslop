class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.9.112/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "d9898356e662d7a61108805d13541a5002df1ac2e1274a2337981938f16cd0f9"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.9.112/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "74d4f88c357f0886e32d018cf686fc0d48fc49a7af482dac213f21d6f3f374c1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.9.112/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "363d9485701c8b90774bbb33d8c865cec0c1067aa730f3b6ee1e828d0f681d08"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.9.112/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7411c485994fafbb26c110cb8b20412e422a03e945e284c79387d10b4e8ce0e5"
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
