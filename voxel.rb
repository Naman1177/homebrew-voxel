class Voxel < Formula
  desc "Decentralized P2P Version Control System"
  homepage "https://github.com/Naman1177/voxel"
  url "https://github.com/Naman1177/voxel/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "4f6058e9b8febc77039de5c2033ba958197ea063444cc77f613d6ac664f96fb1"
  license "MIT"

  depends_on "mbedtls"
  depends_on "zstd"

  def install
    # Dynamically grab the paths for the user's specific Mac architecture
    mbedtls = Formula["mbedtls"]
    zstd = Formula["zstd"]

    # Inject the exact Include (-I) and Library (-L) paths into the compiler
    system "clang++", "-std=c++17", 
           "-I", "inc", 
           "-I", "third_party_lib", 
           "-I#{mbedtls.opt_include}", 
           "-I#{zstd.opt_include}",
           *Dir["src/*.cpp"], 
           "-o", "voxel", 
           "-L#{mbedtls.opt_lib}", 
           "-L#{zstd.opt_lib}", 
           "-lmbedcrypto", "-lzstd"
    
    bin.install "voxel"
  end

  test do
    system "#{bin}/voxel", "--help"
  end
end
