# To use this formula, run
#   $ brew install --build-from-source <PATH_TO_THIS_FILE>
# On first run of cmus, I had to set the output plugin. On macOS do
#   :set output_plugin=coreaudio
# To see the list of available plugins run
#   $ cmus --plugins
class Cmus < Formula
  desc "Music player with an ncurses based interface"
  homepage "https://cmus.github.io/"
  url "https://github.com/asnr/cmus/archive/asnr-1.0.0.tar.gz"
  sha256 "f5dc51cee8980e1fb7f60186b2b05ece2d18729127528eb15d27b23058f02134"
  revision 1
  head "https://github.com/asnr/cmus.git"

  # bottle do
  #   rebuild 1
  #   sha256 "d89a46acdec0e5830d41d2d40419d62fe555f34b99f93bf758e749e023e9b294" => :catalina
  #   sha256 "5597b87c7fcdceec789103df12ae89408e69f98668da522b7ee6a908e622c290" => :mojave
  #   sha256 "38f6dda244d82bc960b7e1c65e2e0316c2cde6cc61174bad763b7243e6f88ad8" => :high_sierra
  #   sha256 "42cab3ddb96e7b36b2b8cf67d2384adea5169e2955841c35166aece5afcd9329" => :sierra
  # end

  depends_on "pkg-config" => :build
  depends_on "faad2"
  depends_on "ffmpeg"
  depends_on "flac"
  depends_on "libcue"
  depends_on "libogg"
  depends_on "libvorbis"
  depends_on "mad"
  depends_on "mp4v2"
  depends_on "opusfile"

  def install
    system "./configure", "prefix=#{prefix}", "mandir=#{man}"
    system "make", "install"
  end

  test do
    system "#{bin}/cmus", "--plugins"
  end
end
