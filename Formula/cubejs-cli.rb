require "language/node"

class CubejsCli < Formula
  desc "Cube.js command-line interface"
  homepage "https://cube.dev/"
  url "https://registry.npmjs.org/cubejs-cli/-/cubejs-cli-0.27.21.tgz"
  sha256 "d5b8e5ace3a2701428938beb3c2b3302ab8b9a7b103aad2c0703bcd18b063081"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4de82911560479a4742a9e532fcf3a9ae5bf95debdd8f64110e68c0355faf505"
    sha256 cellar: :any_skip_relocation, big_sur:       "3ea422912b524891eb4dae74638e47939cc542a3e8c10ab3f0abcefd76e3b55a"
    sha256 cellar: :any_skip_relocation, catalina:      "3ea422912b524891eb4dae74638e47939cc542a3e8c10ab3f0abcefd76e3b55a"
    sha256 cellar: :any_skip_relocation, mojave:        "3ea422912b524891eb4dae74638e47939cc542a3e8c10ab3f0abcefd76e3b55a"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cubejs --version")
    system "cubejs", "create", "hello-world", "-d", "postgres"
    assert_predicate testpath/"hello-world/schema/Orders.js", :exist?
  end
end
