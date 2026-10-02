class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.102/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "e1c28623e1f09fb09c62915485f5dace8a1f2bf31792cff138ab680fc6a79521"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.102/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "54b5f7994988fa80c42d868f07b0720442fdab274685766c4636bd60890dcda6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.102/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6d8562b105a672482ecc25fffbd3cb7a5972a1ab5e4883ba2ebab302b4952ac2"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.102/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7160adfbbee7e81d2d82d9513afb887d5ebacf7515a087c3d82cba381e9fcebf"
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
