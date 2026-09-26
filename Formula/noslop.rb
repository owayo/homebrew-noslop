class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.9.109/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "e0bafddec6698a20eaeafba8c526809249895d13d90c115b28ca37a55c747f3e"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.9.109/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "b84c95534c000ab3149034e3bc0fe34f76141d1f0981328c465f2b7dd20c394b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.9.109/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "805a3d6e71a964953d6c8c2104c2c71a3092f60fb595179e7be270c530bbe229"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.9.109/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a3cfde107a2c66de16386560fc96b918f98bb7dd87e9153f3dd79f912ecca0ce"
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
