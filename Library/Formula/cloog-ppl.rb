require 'formula'

class CloogPpl <Formula
  url 'ftp://gcc.gnu.org//pub/gcc/infrastructure//cloog-ppl-0.15.9.tar.gz'
  homepage 'http://www.cloog.org/'
  md5 '806e001d1b1a6b130069ff6274900af5'

  depends_on "ppl"

  def install
    #ENV.append 'CPPFLAGS', "-I#{prefix}/include"
    system "./configure", "--prefix=#{prefix}",
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--infodir=#{prefix}/share/info",
                          "--mandir=#{man}",
                          "--with-ppl"
                          
    system "make"
    system "make install"
  end
end
