class Xeno < Formula
  desc "Claude code based AI agent"
  homepage "https://github.com/jiulongw/xeno"
  url "https://github.com/jiulongw/xeno/releases/download/v0.2.0/xeno-v0.2.0.tar.gz"
  sha256 "96d1f98829970acbe2c9c2e62745a2d16dd906e737dbf1470e05890cdf9a06ce"
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
