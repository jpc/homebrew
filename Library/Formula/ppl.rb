require 'formula'

class Ppl <Formula
  url 'http://www.cs.unipr.it/ppl/Download/ftp/releases/0.10.2/ppl-0.10.2.tar.bz2'
  head 'http://www.cs.unipr.it/ppl/Download/ftp/snapshots/ppl-0.11pre24.tar.bz2'
  homepage 'http://www.cs.unipr.it/ppl/'

  if ARGV.build_head?
    md5 '14f4d5297a161f9ba22c33945fc61a27'
  else
    md5 '5667111f53150618b0fa522ffc53fc3e'
  end

  depends_on 'gmp'

  def patches
    # changes in gmp 5 interfere with gmp detection in configure
    if not ARGV.include? "--HEAD"
      DATA
    end
  end

  def install
    if not ARGV.include? "--HEAD"    
      # needed after patching the m4 files
      system "autoconf"
    end
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-optimization=sspeed"
    system "make install"
  end
end

__END__
X-Git-Url: http://www.cs.unipr.it/git/gitweb.cgi?p=ppl%2Fppl.git;a=blobdiff_plain;f=m4%2Fac_check_gmp.m4;h=15acb182ed2d386e899fcdf6eeb9ea5b8fb3b90c;hp=60cecdccead332c2d3b7674fb8683b2afd7ace14;hb=9c19bc2b318a35016e0189f9552c98910be37f53;hpb=488f55fbe874c4f3a85c0c0db8c59f7e83d615e0

diff --git a/m4/ac_check_gmp.m4 b/m4/ac_check_gmp.m4
index 60cecdc..15acb18 100644
--- a/m4/ac_check_gmp.m4
+++ b/m4/ac_check_gmp.m4
@@ -71,6 +71,10 @@ AC_RUN_IFELSE([AC_LANG_SOURCE([[
 #GMP version 4.1.3 or higher is required
 #endif
 
+#ifndef BITS_PER_MP_LIMB
+#define BITS_PER_MP_LIMB GMP_LIMB_BITS
+#endif
+
 int
 main() {
   std::string header_version;
@@ -97,11 +101,11 @@ main() {
     return 1;
   }
 
-  if (sizeof(mp_limb_t)*CHAR_BIT != GMP_LIMB_BITS
-      || GMP_LIMB_BITS != mp_bits_per_limb) {
+  if (sizeof(mp_limb_t)*CHAR_BIT != BITS_PER_MP_LIMB
+      || BITS_PER_MP_LIMB != mp_bits_per_limb) {
     std::cerr
       << "GMP header (gmp.h) and library (ligmp.*) bits-per-limb mismatch:\n"
-      << "header gives " << __GMP_BITS_PER_MP_LIMB << ";\n"
+      << "header gives " << BITS_PER_MP_LIMB << ";\n"
       << "library gives " << mp_bits_per_limb << ".\n"
       << "This probably means you are on a bi-arch system and\n"
       << "you are compiling with the wrong header or linking with\n"
