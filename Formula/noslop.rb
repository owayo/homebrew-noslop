class Noslop < Formula
  desc "Linter that flags AI-sounding patterns in Japanese text"
  homepage "https://github.com/owayo/noslop"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.109/noslop-aarch64-apple-darwin.tar.gz"
      sha256 "c961baa7dabe896d664a61dd24baa2a4230b7a92ad305c9414bf8cedc398bc2a"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.109/noslop-x86_64-apple-darwin.tar.gz"
      sha256 "6057e057518ae94b77d1922c5967c40d29440ac6b26a5d6a744eba24ef83e3c8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/owayo/noslop/releases/download/v26.10.109/noslop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7fee0ec6437886511c60b71a216183c2b2814fde8ae4925d57dc78878d924603"
    else
      url "https://github.com/owayo/noslop/releases/download/v26.10.109/noslop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c69695fa1100ade77f53420eb0ede3ea31cd6c3234595ea1061e415138c2b442"
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
