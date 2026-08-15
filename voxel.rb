class Voxel < Formula
  desc "Decentralized P2P Version Control System"
  homepage "https://github.com/Naman1177/voxel"
  url "https://github.com/Naman1177/voxel/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "4f6058e9b8febc77039de5c2033ba958197ea063444cc77f613d6ac664f96fb1"
  license "MIT"

  # Explicitly tell Homebrew to bring these libraries into the build sandbox
  depends_on "mbedtls"
  depends_on "zstd"

  def install
    # Added -lmbedcrypto and -lzstd so the linker can build the final executable
    system "clang++", "-std=c++17", "-I", "inc", "-I", "third_party_lib", *Dir["src/*.cpp"], "-o", "voxel", "-lmbedcrypto", "-lzstd"
    
    bin.install "voxel"
  end

  test do
    system "#{bin}/voxel", "--help"
  end
end
