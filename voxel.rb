class Voxel < Formula
  desc "Decentralized P2P Version Control System"
  homepage "https://github.com/Naman1177/Voxel"
  url "https://github.com/Naman1177/Voxel/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "4f6058e9b8febc77039de5c2033ba958197ea063444cc77f613d6ac664f96fb1"
  license "MIT"

  # If you are using standard macOS frameworks, you don't need many dependencies.
  # But if you rely on an external Zstd library, uncomment the line below:
  # depends_on "zstd"

  def install
    # This executes your clang++ build command exactly as you run it in the terminal
    system "clang++", "-std=c++17", "-I", "inc", "-I", "third_party_lib", *Dir["src/*.cpp"], "-o", "voxel"
    
    # This moves the compiled binary into the global Homebrew path so the user can type 'voxel' anywhere
    bin.install "voxel"
  end

  test do
    # A quick test to ensure the binary installed correctly
    system "#{bin}/voxel", "--help"
  end
end
