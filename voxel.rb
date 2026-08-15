class Voxel < Formula
  desc "High performance, decentralized P2P version control system"
  homepage "https://github.com/Naman1177/voxel"
  url "https://github.com/Naman1177/voxel/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "4f6058e9b8febc77039de5c2033ba958197ea063444cc77f613d6ac664f96fb1"
  license "MIT"

  # No depends_on needed! Voxel natively bundles its own cryptography and compression.

  def install
    # Explicitly compile the Voxel source alongside the bundled mbedtls and zstd libraries
    system ENV.cxx, "-std=c++17", 
           "-Iinc", 
           "-Ithird_party_lib/mbedtls/inc", 
           "-Ithird_party_lib/zstd", 
           *Dir["src/*.cpp"], 
           *Dir["third_party_lib/mbedtls/src/*.c"], 
           *Dir["third_party_lib/zstd/common/*.c"], 
           *Dir["third_party_lib/zstd/compress/*.c"], 
           *Dir["third_party_lib/zstd/decompress/*.c"], 
           "-o", "voxel"
    
    # Installs the compiled binary into the user's terminal
    bin.install "voxel"
  end

  test do
    system "#{bin}/voxel", "status"
  end
end
