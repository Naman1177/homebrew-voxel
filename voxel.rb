class Voxel < Formula
  desc "High performance, decentralized P2P version control system"
  homepage "https://github.com/Naman1177/voxel"
  url "https://github.com/Naman1177/voxel/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "4f6058e9b8febc77039de5c2033ba958197ea063444cc77f613d6ac664f96fb1"
  license "MIT"

  def install
    # Step 1: Compile the C libraries into object (.o) files using ENV.cc (gcc)
    system ENV.cc, "-c", 
           *Dir["third_party_lib/zstd/common/*.c"], 
           *Dir["third_party_lib/zstd/compress/*.c"], 
           *Dir["third_party_lib/zstd/decompress/*.c"], 
           *Dir["third_party_lib/mbedtls/src/*.c"], 
           "-Ithird_party_lib/zstd", 
           "-Ithird_party_lib/mbedtls/inc", 
           "-Ithird_party_lib"

    # Step 2: Compile the C++ source, link the .o files, and build the binary using ENV.cxx (g++)
    system ENV.cxx, "-std=c++17", 
           *Dir["src/*.cpp"], 
           *Dir["*.o"], 
           "-Iinc", 
           "-Ithird_party_lib/zstd", 
           "-Ithird_party_lib", 
           "-Ithird_party_lib/mbedtls/inc", 
           "-Ithird_party_lib/ai_parser", 
           "-Ithird_party_lib/dtl", 
           "-Wno-c++11-narrowing", 
           "-Wno-deprecated", 
           "-o", "voxel"
    
    # Step 3: Install the final binary into Homebrew's global environment path
    bin.install "voxel"
  end

  test do
    # Verifies the global binary runs successfully
    system "#{bin}/voxel", "status"
  end
end
