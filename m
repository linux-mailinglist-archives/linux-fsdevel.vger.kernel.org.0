Return-Path: <linux-fsdevel+bounces-38067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E9C9FB4BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 20:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB288165D90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 19:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336471C3BF7;
	Mon, 23 Dec 2024 19:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bm4jQmXA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576CA1AF0C2;
	Mon, 23 Dec 2024 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734982647; cv=none; b=kUEFtuEAKABtMrPGHTbb7jU34Tv78Trvdak+WtFqerbQ65NqfWHDb/oxbJYRRHj1zVY5oIdVVlRN3wGcciIkJrfJq3d1pkvRbK/u4Y/3HXik+9+1CWT9YQUq+1AbStYCSLc7XvjhiwMJo8QxZ57lBi78TzxqrkbNwfUEwRr9WR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734982647; c=relaxed/simple;
	bh=hmC3rFO6wdRfoXU8yuLwMcE5KynuT7kDAewh0ZPuI0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4scAW7+yA7m5F3sXbPYAtmDIXo4PV3cx3KaRzfJpkQmCdVGO+Hxu8Zulrxxu23PpP+K6QbhBYJMoQPxqiBlE8trFlyBSdjABOLkL2ItqkQ41z77XTbj+6ulErhDTDNeikVrTkSD7RLWmYH5j84TbtTVuXw0gu5wA6WNrokMPmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bm4jQmXA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vZrvt6BQWmuKEJES6QK8a+m9TLZN/dN1RXxGQ1WwsYQ=; b=bm4jQmXAlLVGOnVcXuhkD+a3+V
	8HGPzx38R3DcxLHHdHNRE3qUfh7se+q8UUQ4QvVP1Mfdk7f243zQxN/8MQLbV7S2FWbG3FGxz3FUC
	cIodKQr8fPirvltYq+SgHCoO6J5vYQI/Oaqsyr2535n0AUJSqNT+0Q1lMLXWh2p8L7WGdOpZDAw+x
	/ogE6I8a4bB/pXkRmPcEptxHFYnf1M1fLRrlQUHXLPi0c+nm3KwjHAma7NrT2jlqJH4Os+E5WgSL0
	WkimCPSGGeEJ0qRinTnNDadaUNGqFn3Wlvt70cUfoBH8rL5VqoNANqZUKZcW+ck76VeUmH9RWUdKB
	BXeRkjjA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tPoEz-0000000BPUo-15Pr;
	Mon, 23 Dec 2024 19:37:21 +0000
Date: Mon, 23 Dec 2024 19:37:21 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:work.dcache 6/6] fs/libfs.c:1819:10: warning:
 comparison of distinct pointer types ('const char *' and 'const unsigned
 char *')
Message-ID: <20241223193721.GN1977892@ZenIV>
References: <202412231828.bq5nr63U-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202412231828.bq5nr63U-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 23, 2024 at 06:55:39PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dcache
> head:   08141fdc186755910b5bffc21a4325e2b673629f
> commit: 7cd7d43774879a6d7fc35662fb788ed8210dd09a [6/6] generic_ci_d_compare(): use shortname_storage
> config: arm-randconfig-002-20241223 (https://download.01.org/0day-ci/archive/20241223/202412231828.bq5nr63U-lkp@intel.com/config)
> compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241223/202412231828.bq5nr63U-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202412231828.bq5nr63U-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> fs/libfs.c:1819:10: warning: comparison of distinct pointer types ('const char *' and 'const unsigned char *') [-Wcompare-distinct-pointer-types]
>            if (str == dentry->d_shortname.string) {
>                ~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~

The funny thing is, str is the third argument of ->d_compare() instance.
Yes, it's declared as
        int (*d_compare)(const struct dentry *,
			unsigned int, const char *, const struct qstr *);

But in all callers the actual argument comes from ->name of some struct
qstr, which is const unsigned char *.  And from the look through the
instances, declaring that argument as const unsigned char * does not
cause any complications...

Not sure if it's worth bothering with, TBH...  We have -funsigned-char
anyway, OTOH the patch needed to switch that one is not large.  Folks,
does anybody have strong preferences?

diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index 77fbd196008f..49c658481a61 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -330,7 +330,7 @@ static unsigned char adfs_tolower(unsigned char c)
 }
 
 static int __adfs_compare(const unsigned char *qstr, u32 qlen,
-			  const char *str, u32 len)
+			  const unsigned char *str, u32 len)
 {
 	u32 i;
 
@@ -416,7 +416,7 @@ adfs_hash(const struct dentry *parent, struct qstr *qstr)
  * requirements of the underlying filesystem.
  */
 static int adfs_compare(const struct dentry *dentry, unsigned int len,
-			const char *str, const struct qstr *qstr)
+			const unsigned char *str, const struct qstr *qstr)
 {
 	return __adfs_compare(qstr->name, qstr->len, str, len);
 }
diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index 8c154490a2d6..6ec2c1b557fe 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -80,7 +80,7 @@ affs_intl_hash_dentry(const struct dentry *dentry, struct qstr *qstr)
 }
 
 static inline int __affs_compare_dentry(unsigned int len,
-		const char *str, const struct qstr *name, toupper_t fn,
+		const unsigned char *str, const struct qstr *name, toupper_t fn,
 		bool notruncate)
 {
 	const u8 *aname = str;
@@ -113,8 +113,8 @@ static inline int __affs_compare_dentry(unsigned int len,
 }
 
 static int
-affs_compare_dentry(const struct dentry *dentry,
-		unsigned int len, const char *str, const struct qstr *name)
+affs_compare_dentry(const struct dentry *dentry, unsigned int len,
+		    const unsigned char *str, const struct qstr *name)
 {
 
 	return __affs_compare_dentry(len, str, name, affs_toupper,
@@ -122,8 +122,8 @@ affs_compare_dentry(const struct dentry *dentry,
 }
 
 static int
-affs_intl_compare_dentry(const struct dentry *dentry,
-		unsigned int len, const char *str, const struct qstr *name)
+affs_intl_compare_dentry(const struct dentry *dentry, unsigned int len,
+			 const unsigned char *str, const struct qstr *name)
 {
 	return __affs_compare_dentry(len, str, name, affs_intl_toupper,
 				     affs_nofilenametruncate(dentry));
diff --git a/fs/dcache.c b/fs/dcache.c
index 7d42ca367522..697e892bcc03 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2151,7 +2151,7 @@ static noinline struct dentry *__d_lookup_rcu_op_compare(
 
 	hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
 		int tlen;
-		const char *tname;
+		const unsigned char *tname;
 		unsigned seq;
 
 seqretry:
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index a929f1b613be..ee203f75d275 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -122,7 +122,7 @@ static const struct super_operations efivarfs_ops = {
  * case-insensitive match on part 2.
  */
 static int efivarfs_d_compare(const struct dentry *dentry,
-			      unsigned int len, const char *str,
+			      unsigned int len, const unsigned char *str,
 			      const struct qstr *name)
 {
 	int guid = len - EFI_VARIABLE_GUID_LEN;
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 97d2774760fe..989bb3dd47ba 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -104,7 +104,7 @@ static int exfat_d_hash(const struct dentry *dentry, struct qstr *qstr)
 }
 
 static int exfat_d_cmp(const struct dentry *dentry, unsigned int len,
-		const char *str, const struct qstr *name)
+		const unsigned char *str, const struct qstr *name)
 {
 	struct super_block *sb = dentry->d_sb;
 	struct nls_table *t = EXFAT_SB(sb)->nls_io;
@@ -165,7 +165,7 @@ static int exfat_utf8_d_hash(const struct dentry *dentry, struct qstr *qstr)
 }
 
 static int exfat_utf8_d_cmp(const struct dentry *dentry, unsigned int len,
-		const char *str, const struct qstr *name)
+		const unsigned char *str, const struct qstr *name)
 {
 	struct super_block *sb = dentry->d_sb;
 	unsigned int alen = exfat_striptail_len(name->len, name->name,
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index f06f6ba643cc..6a1f95d0e4d1 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -164,8 +164,8 @@ static int msdos_hash(const struct dentry *dentry, struct qstr *qstr)
  * Compare two msdos names. If either of the names are invalid,
  * we fall back to doing the standard name comparison.
  */
-static int msdos_cmp(const struct dentry *dentry,
-		unsigned int len, const char *str, const struct qstr *name)
+static int msdos_cmp(const struct dentry *dentry, unsigned int len,
+		     const unsigned char *str, const struct qstr *name)
 {
 	struct fat_mount_options *options = &MSDOS_SB(dentry->d_sb)->options;
 	unsigned char a_msdos_name[MSDOS_NAME], b_msdos_name[MSDOS_NAME];
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 15bf32c21ac0..504a51f8d7c5 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -152,8 +152,8 @@ static int vfat_hashi(const struct dentry *dentry, struct qstr *qstr)
 /*
  * Case insensitive compare of two vfat names.
  */
-static int vfat_cmpi(const struct dentry *dentry,
-		unsigned int len, const char *str, const struct qstr *name)
+static int vfat_cmpi(const struct dentry *dentry, unsigned int len,
+		     const unsigned char *str, const struct qstr *name)
 {
 	struct nls_table *t = MSDOS_SB(dentry->d_sb)->nls_io;
 	unsigned int alen, blen;
@@ -171,8 +171,8 @@ static int vfat_cmpi(const struct dentry *dentry,
 /*
  * Case sensitive compare of two vfat names.
  */
-static int vfat_cmp(const struct dentry *dentry,
-		unsigned int len, const char *str, const struct qstr *name)
+static int vfat_cmp(const struct dentry *dentry, unsigned int len,
+		    const unsigned char *str, const struct qstr *name)
 {
 	unsigned int alen, blen;
 
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index a0c7cb0f79fc..4b34ecefb828 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -233,7 +233,7 @@ extern int hfs_hash_dentry(const struct dentry *, struct qstr *);
 extern int hfs_strcmp(const unsigned char *, unsigned int,
 		      const unsigned char *, unsigned int);
 extern int hfs_compare_dentry(const struct dentry *dentry,
-		unsigned int len, const char *str, const struct qstr *name);
+		unsigned int len, const unsigned char *str, const struct qstr *name);
 
 /* trans.c */
 extern void hfs_asc2mac(struct super_block *, struct hfs_name *, const struct qstr *);
diff --git a/fs/hfs/string.c b/fs/hfs/string.c
index 3912209153a8..b2a4336e1a4b 100644
--- a/fs/hfs/string.c
+++ b/fs/hfs/string.c
@@ -92,8 +92,8 @@ int hfs_strcmp(const unsigned char *s1, unsigned int len1,
  * Test for equality of two strings in the HFS filename character ordering.
  * return 1 on failure and 0 on success
  */
-int hfs_compare_dentry(const struct dentry *dentry,
-		unsigned int len, const char *str, const struct qstr *name)
+int hfs_compare_dentry(const struct dentry *dentry, unsigned int len,
+		       const unsigned char *str, const struct qstr *name)
 {
 	const unsigned char *n1, *n2;
 
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 2f089bff0095..469cf905faac 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -525,7 +525,7 @@ int hfsplus_asc2uni(struct super_block *sb, struct hfsplus_unistr *ustr,
 		    int max_unistr_len, const char *astr, int len);
 int hfsplus_hash_dentry(const struct dentry *dentry, struct qstr *str);
 int hfsplus_compare_dentry(const struct dentry *dentry, unsigned int len,
-			   const char *str, const struct qstr *name);
+			   const unsigned char *str, const struct qstr *name);
 
 /* wrapper.c */
 int hfsplus_submit_bio(struct super_block *sb, sector_t sector, void *buf,
diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 73342c925a4b..e166f0d505aa 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -433,8 +433,8 @@ int hfsplus_hash_dentry(const struct dentry *dentry, struct qstr *str)
  * Composed unicode characters are decomposed and case-folding is performed
  * if the appropriate bits are (un)set on the superblock.
  */
-int hfsplus_compare_dentry(const struct dentry *dentry,
-		unsigned int len, const char *str, const struct qstr *name)
+int hfsplus_compare_dentry(const struct dentry *dentry, unsigned int len,
+			   const unsigned char *str, const struct qstr *name)
 {
 	struct super_block *sb = dentry->d_sb;
 	int casefold, decompose, size;
diff --git a/fs/hpfs/dentry.c b/fs/hpfs/dentry.c
index 89a36fdc68cb..4a28915b5185 100644
--- a/fs/hpfs/dentry.c
+++ b/fs/hpfs/dentry.c
@@ -35,8 +35,8 @@ static int hpfs_hash_dentry(const struct dentry *dentry, struct qstr *qstr)
 	return 0;
 }
 
-static int hpfs_compare_dentry(const struct dentry *dentry,
-		unsigned int len, const char *str, const struct qstr *name)
+static int hpfs_compare_dentry(const struct dentry *dentry, unsigned int len,
+			       const unsigned char *str, const struct qstr *name)
 {
 	unsigned al = len;
 	unsigned bl = name->len;
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 47038e660812..29e68169b523 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -37,16 +37,16 @@
 #define BEQUIET
 
 static int isofs_hashi(const struct dentry *parent, struct qstr *qstr);
-static int isofs_dentry_cmpi(const struct dentry *dentry,
-		unsigned int len, const char *str, const struct qstr *name);
+static int isofs_dentry_cmpi(const struct dentry *dentry, unsigned int len,
+		const unsigned char *str, const struct qstr *name);
 
 #ifdef CONFIG_JOLIET
 static int isofs_hashi_ms(const struct dentry *parent, struct qstr *qstr);
 static int isofs_hash_ms(const struct dentry *parent, struct qstr *qstr);
-static int isofs_dentry_cmpi_ms(const struct dentry *dentry,
-		unsigned int len, const char *str, const struct qstr *name);
-static int isofs_dentry_cmp_ms(const struct dentry *dentry,
-		unsigned int len, const char *str, const struct qstr *name);
+static int isofs_dentry_cmpi_ms(const struct dentry *dentry, unsigned int len,
+		const unsigned char *str, const struct qstr *name);
+static int isofs_dentry_cmp_ms(const struct dentry *dentry, unsigned int len,
+		const unsigned char *str, const struct qstr *name);
 #endif
 
 static void isofs_put_super(struct super_block *sb)
@@ -200,7 +200,7 @@ isofs_hashi_common(const struct dentry *dentry, struct qstr *qstr, int ms)
  * Compare of two isofs names.
  */
 static int isofs_dentry_cmp_common(
-		unsigned int len, const char *str,
+		unsigned int len, const unsigned char *str,
 		const struct qstr *name, int ms, int ci)
 {
 	int alen, blen;
@@ -233,8 +233,8 @@ isofs_hashi(const struct dentry *dentry, struct qstr *qstr)
 }
 
 static int
-isofs_dentry_cmpi(const struct dentry *dentry,
-		unsigned int len, const char *str, const struct qstr *name)
+isofs_dentry_cmpi(const struct dentry *dentry, unsigned int len,
+		  const unsigned char *str, const struct qstr *name)
 {
 	return isofs_dentry_cmp_common(len, str, name, 0, 1);
 }
@@ -274,15 +274,15 @@ isofs_hashi_ms(const struct dentry *dentry, struct qstr *qstr)
 }
 
 static int
-isofs_dentry_cmp_ms(const struct dentry *dentry,
-		unsigned int len, const char *str, const struct qstr *name)
+isofs_dentry_cmp_ms(const struct dentry *dentry, unsigned int len,
+		    const unsigned char *str, const struct qstr *name)
 {
 	return isofs_dentry_cmp_common(len, str, name, 1, 0);
 }
 
 static int
-isofs_dentry_cmpi_ms(const struct dentry *dentry,
-		unsigned int len, const char *str, const struct qstr *name)
+isofs_dentry_cmpi_ms(const struct dentry *dentry, unsigned int len,
+		     const unsigned char *str, const struct qstr *name)
 {
 	return isofs_dentry_cmp_common(len, str, name, 1, 1);
 }
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index d68a4e6ac345..7aedb3c772ba 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -1560,8 +1560,8 @@ static int jfs_ci_hash(const struct dentry *dir, struct qstr *this)
 	return 0;
 }
 
-static int jfs_ci_compare(const struct dentry *dentry,
-		unsigned int len, const char *str, const struct qstr *name)
+static int jfs_ci_compare(const struct dentry *dentry, unsigned int len,
+			  const unsigned char *str, const struct qstr *name)
 {
 	int i, result = 1;
 
diff --git a/fs/libfs.c b/fs/libfs.c
index 9e3ece8c97be..382d183425a4 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1785,7 +1785,7 @@ bool is_empty_dir_inode(struct inode *inode)
  * Return: 0 if names match, 1 if mismatch, or -ERRNO
  */
 int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
-			 const char *str, const struct qstr *name)
+			 const unsigned char *str, const struct qstr *name)
 {
 	const struct dentry *parent;
 	const struct inode *dir;
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index abf7e81584a9..36a5a0f0efbb 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -425,7 +425,7 @@ static int ntfs_d_hash(const struct dentry *dentry, struct qstr *name)
  * dentry_operations::d_compare
  */
 static int ntfs_d_compare(const struct dentry *dentry, unsigned int len1,
-			  const char *str, const struct qstr *name)
+			  const unsigned char *str, const struct qstr *name)
 {
 	struct ntfs_sb_info *sbi;
 	int ret;
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 27a283d85a6e..91995da3bda4 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -911,8 +911,8 @@ static int sysctl_is_seen(struct ctl_table_header *p)
 	return res;
 }
 
-static int proc_sys_compare(const struct dentry *dentry,
-		unsigned int len, const char *str, const struct qstr *name)
+static int proc_sys_compare(const struct dentry *dentry, unsigned int len,
+			    const unsigned char *str, const struct qstr *name)
 {
 	struct ctl_table_header *head;
 	struct inode *inode;
diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index 864b194dbaa0..f680751b07d8 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -844,8 +844,8 @@ static int cifs_ci_hash(const struct dentry *dentry, struct qstr *q)
 	return 0;
 }
 
-static int cifs_ci_compare(const struct dentry *dentry,
-		unsigned int len, const char *str, const struct qstr *name)
+static int cifs_ci_compare(const struct dentry *dentry, unsigned int len,
+		const unsigned char *str, const struct qstr *name)
 {
 	struct nls_table *codepage = CIFS_SB(dentry->d_sb)->local_nls;
 	wchar_t c1, c2;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 8bc567a35718..d16a89513115 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -147,8 +147,8 @@ struct dentry_operations {
 	int (*d_revalidate)(struct dentry *, unsigned int);
 	int (*d_weak_revalidate)(struct dentry *, unsigned int);
 	int (*d_hash)(const struct dentry *, struct qstr *);
-	int (*d_compare)(const struct dentry *,
-			unsigned int, const char *, const struct qstr *);
+	int (*d_compare)(const struct dentry *, unsigned int,
+			 const unsigned char *, const struct qstr *);
 	int (*d_delete)(const struct dentry *);
 	int (*d_init)(struct dentry *);
 	void (*d_release)(struct dentry *);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7e29433c5ecc..6524e0ec1b39 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3493,7 +3493,7 @@ extern int generic_ci_match(const struct inode *parent,
 #if IS_ENABLED(CONFIG_UNICODE)
 int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str);
 int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
-			 const char *str, const struct qstr *name);
+			 const unsigned char *str, const struct qstr *name);
 
 /**
  * generic_ci_validate_strict_name - Check if a given name is suitable

