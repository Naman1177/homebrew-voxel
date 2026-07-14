class Voxel < Formula
  desc "High performance, lightweight version control system and local file engine"
  homepage "https://github.com/Naman1177/Voxel"
  url "https://github.com/Naman1177/Voxel/archive/refs/tags/v1.0.0-alpha.tar.gz"
  sha256 "90833ef59815f0f9f6a3708020fe56ca22f19775350507d0d01841c7a3537733"
  license "MIT"

  # Tells Homebrew that CMake is required to compile your C++ project
  depends_on "cmake" => :build

  def install
    # Configures the project using the CMakeLists.txt you built
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    
    # Compiles the binary
    system "cmake", "--build", "build"
    
    # Installs the binary into Homebrew's global environment path
    system "cmake", "--install", "build"
  end

  test do
    # Verifies the global binary runs successfully
    system "#{bin}/voxel", "--version"
  end
end
