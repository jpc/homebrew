require 'formula'

class Binutils <Formula
  url 'http://ftp.gnu.org/gnu/binutils/binutils-2.20.tar.gz'
  homepage 'http://www.gnu.org/software/binutils/binutils.html'
  md5 'e99487e0c4343d6fa68b7c464ff4a962'
end

class ArmNoneEabiGcc <Formula
  url 'http://ftp.gnu.org/gnu/gcc/gcc-4.4.4/gcc-4.4.4.tar.bz2'
  homepage 'http://gcc.gnu.org/'
  md5 '7ff5ce9e5f0b088ab48720bbd7203530'

  depends_on "mpfr"
  depends_on "cloog-ppl"

  def install
    target = "arm-none-eabi"

    Binutils.new.brew {
      system "./configure", "--target=#{target}",
                            "--prefix=#{prefix}",
                            "--disable-debug",
                            "--disable-dependency-tracking",
                            "--infodir=#{prefix}/share/info",
                            "--mandir=#{man}",
                            "--enable-interwork",
                            "--enable-multilib",
                            "--disable-nls",     # FIXME: check these three
                            "--disable-shared",  #
                            "--disable-threads", #
                            "--with-gcc",
                            "--with-gnu-as",
                            "--with-gnu-ld",
                            "--disable-werror"
                          
      system "make"
      system "make install"
    }

    system "./configure", "--target=#{target}",
                          "--prefix=#{prefix}",
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--infodir=#{prefix}/share/info",
                          "--mandir=#{man}",
                          "--enable-interwork",
                          "--enable-multilib",
                          "--disable-nls",     # FIXME: check these three
                          "--disable-shared",  #
                          "--disable-threads", #
                          #"--with-newlib",
                          "--without-headers",
                          "--disable-libssp",
                          "--disable-libmudflap",
                          "--disable-libgomp",
                          "--disable-libunwind-exceptions",
                          "--disable-libffi",
                          "--disable-libstdcxx-pch",
                          "--enable-lto",
                          "--enable-gold",
                          "--with-dwarf2",
                          "--enable-languages=c,c++",
                          "--with-gnu-as=/usr/local",
                          "--with-gnu-ld=/usr/local"
                          
    system "make all-gcc"
    system "make install-gcc"
  end
end
