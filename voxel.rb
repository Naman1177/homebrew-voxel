class Voxel < Formula
  desc "High performance, decentralized P2P version control system"
  homepage "https://github.com/Naman1177/voxel"
  url "https://github.com/Naman1177/voxel/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "4f6058e9b8febc77039de5c2033ba958197ea063444cc77f613d6ac664f96fb1"
  license "MIT"

  # Tells Homebrew to bring these libraries into the build sandbox
  depends_on "mbedtls"
  depends_on "zstd"

  def install
    # ENV.cxx automatically injects the include/library paths for mbedtls and zstd
    system ENV.cxx, "-std=c++17", "-Iinc", "-Ithird_party_lib", *Dir["src/*.cpp"], "-o", "voxel", "-lmbedcrypto", "-lzstd"
    
    # Installs the binary into Homebrew's global environment path
    bin.install "voxel"
  end

  test do
    # Verifies the global binary runs successfully
    system "#{bin}/voxel", "status"
  end
end
