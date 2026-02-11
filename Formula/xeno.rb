class Xeno < Formula
  desc "Claude code based AI agent"
  homepage "https://github.com/jiulongw/xeno"
  url "https://github.com/jiulongw/xeno/releases/download/v0.1.0/xeno-v0.1.0.tar.gz"
  sha256 "59a06ce97c29fb1c717d6798e8d3a40cfad7aa62801322c0ae4ce64a382c3af4"
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
