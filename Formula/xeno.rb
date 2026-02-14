class Xeno < Formula
  desc "Claude code based AI agent"
  homepage "https://github.com/jiulongw/xeno"
  url "https://github.com/jiulongw/xeno/releases/download/v0.2.2/xeno-v0.2.2.tar.gz"
  sha256 "0c961d6f4114346a786c6bf7b41084f268bc314ca0d643c53e6ba238129c54e3"
  head "https://github.com/jiulongw/xeno.git", branch: "main"

  depends_on "oven-sh/bun/bun"

  def install
    if build.head?
      system Formula["oven-sh/bun/bun"].opt_bin/"bun", "install", "--frozen-lockfile"
      system Formula["oven-sh/bun/bun"].opt_bin/"bun", "run", "bundle"
    end

    # Package the prebuilt runtime bundle and assets from xeno/bin.
    libexec.install "bin"

    (bin/"xeno").write <<~EOS
      #!/bin/bash
      exec "#{Formula["oven-sh/bun/bun"].opt_bin}/bun" "#{libexec}/bin/xeno.js" "$@"
    EOS
  end

  test do
    output = shell_output("#{bin}/xeno 2>&1", 1)
    assert_match "Usage: xeno <command> --home <path>", output
  end
end
