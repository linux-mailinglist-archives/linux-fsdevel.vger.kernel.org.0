Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF530A47CC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 07:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfIAFxd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Sep 2019 01:53:33 -0400
Received: from sonic302-20.consmr.mail.gq1.yahoo.com ([98.137.68.146]:37676
        "EHLO sonic302-20.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725263AbfIAFxd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Sep 2019 01:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1567317211; bh=IqLm2Te437JZlQnlbT22yLI+1o7Mi5v1EWwqC3rlstk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=pUyd5ol8OCS3mb8G7O+7kAHRa5oe0RTm7EtZegCYGyKarg+PR7v639j9+FdYj++BJ3WMfBmE9FkVlxjPXpU8w9DaXMtsanLJ5FaU8ghQIhFzdtP9Yhrg0RyjU1MClTP46ojT7wdNnQXdddkXje9u0okhyFF479i5/GKT763yihIZkZ8kHtjLYD3nThI5q6E4rJnWQWJ0Z8yUl7bEng67mWMEXBFW3JKxb9TifTrEI390TpzLMkJ9GG+jjKyosZR4jbt/xjkSdGjSyi4WrJs4zeS+IFodFHRVikg/5N4l9gip2MhOK9/JNuODJW5l1hXGIWHBDV6B0esf2Vl9qa5mBQ==
X-YMail-OSG: R6BhcIMVM1lnYTV5lV581pi38TtsKX_Tl2b2uGg.pDy5fY.pAJFXkhPqdjIAriD
 9Up.tdaD6UJxhZ1WW.LGJ.PSlWH2NfMaTUjAAPUR4WKvMAVQwNY6oR8HFsWs92sHSNLpb5eSnT6D
 qjmCxAfbAw.NXuObHImS2z6sa7LuM4isKGN5jpfUSeTiFekuwbVBkVwTtKsAbEbXn9RcpHfhTEGW
 .PwDCMAUvjlo2OEr2iRd6rW.D7S75cQzrbEE2hagncg6UHZCQdjGKTSv8z5MPQneeWFuq6tZdZ69
 EkoOc1UMvJkZIjkOpktLyU1LBhaFyNSNkRn0fZzr3ky6GsLIRLgjZbwKsFjeqf0rPNCeYt_WveIt
 SiNiTTP1q0iJ6LC0RcnAJjxXsnURjlVqgSwt3VABhGICARs8gcWPcToY1SILSDFWzRDbaEdQ2cjE
 QOx9WFUWqlis9T7sW9VTluTuHruTlxIhRg1SFJyjI5P93fpl5zezRrqQe7wtR40nOnnNYcXqRgyd
 a7Zh3hDHEwCi3OjlPrq87oAsCf_9p1khKzYP9O24c0RKZETWhYrg8JnXhjxWBELRYsXNLSGTQBKH
 jn506pV9jbDwRLwMQK5O.m_XMeo7up.ekqAOw0UDqYHJ30nr5.0iPw5m093kn7UY1pvARYK.vk5o
 LcL7SrGtrYPc3Mqjhlwogc5E_EGqsvcBOAn3g_MsS.YkWV9ypW_SYANmRsi962.OdCLPNUR6edJ3
 5cjsKlq2F0RFnkgvyC9NxuEL8ItqNFOGLNl5YdJ1QFVn92acuEO.wgp11zWG17AL0TBU57Xk4zDh
 WeScDohWeu1.PsAY4Zh1_5ckrbm5PVkxVZ054knpEXOy.9y0g0ROwLOvkVYPpjjq00xrI058nshE
 EyYD8RCigSALuJGvVqInD0HAImcMfoc5baiIBCRYxI9JM4LOlU9M7UZsPdFSlY_4Xn4oOX70I8jD
 D2I.Rj3kQdLFXBtGPnGFukzAsaeCn6CDXZ7JOTJ8B6N77IKALSjedl9FjaAaHFn3TNdz.VVP9G5A
 xsBXLH04T9UBqzKuv95rkr4XzxZ9.N6nXYzvYov277Dn9.QdksmPLtpg8cKmaVWtoclyKQ4u660t
 s87L5zzm91hM50SY0eeq5BeF8I8e7VX7CMokX1SNOIp4Z70xBExS4Wb1uIhFAwj91Jg3TvYouuNm
 MLiUXJ.d4MIfUVOBq62xRVq8u_n4fCTb0IASk4Q1FfCz7KhzikktbsoLhORku.841U79MKNvF9NL
 HmXj0hwpXBnwqWaVY.GD5_7hE1AKZcqfrY8uqLsSLKe_2FizuRQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 05:53:31 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 426e3b5ec1af9e36f409445c51071a70;
          Sun, 01 Sep 2019 05:53:27 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 19/21] erofs: kill all erofs specific fault injection
Date:   Sun,  1 Sep 2019 13:51:28 +0800
Message-Id: <20190901055130.30572-20-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190901055130.30572-1-hsiangkao@aol.com>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

As Christoph suggested [1], "Please just use plain kmalloc
everywhere and let the normal kernel error injection code
take care of injeting any errors."

[1] https://lore.kernel.org/r/20190829102426.GE20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 Documentation/filesystems/erofs.txt |  5 ---
 fs/erofs/Kconfig                    |  7 ---
 fs/erofs/data.c                     |  6 ---
 fs/erofs/inode.c                    |  3 +-
 fs/erofs/internal.h                 | 65 ---------------------------
 fs/erofs/super.c                    | 70 -----------------------------
 fs/erofs/zdata.c                    |  8 +---
 7 files changed, 2 insertions(+), 162 deletions(-)

diff --git a/Documentation/filesystems/erofs.txt b/Documentation/filesystems/erofs.txt
index 38aa9126ec98..c3b5f603b2b6 100644
--- a/Documentation/filesystems/erofs.txt
+++ b/Documentation/filesystems/erofs.txt
@@ -52,11 +52,6 @@ linux-erofs mailing list:
 Mount options
 =============
 
-fault_injection=%d     Enable fault injection in all supported types with
-                       specified injection rate. Supported injection type:
-                       Type_Name                Type_Value
-                       FAULT_KMALLOC            0x000000001
-                       FAULT_READ_IO            0x000000002
 (no)user_xattr         Setup Extended User Attributes. Note: xattr is enabled
                        by default if CONFIG_EROFS_FS_XATTR is selected.
 (no)acl                Setup POSIX Access Control List. Note: acl is enabled
diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 16316d1adca3..9d634d3a1845 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -27,13 +27,6 @@ config EROFS_FS_DEBUG
 
 	  For daily use, say N.
 
-config EROFS_FAULT_INJECTION
-	bool "EROFS fault injection facility"
-	depends on EROFS_FS
-	help
-	  Test EROFS to inject faults such as ENOMEM, EIO, and so on.
-	  If unsure, say N.
-
 config EROFS_FS_XATTR
 	bool "EROFS extended attributes"
 	depends on EROFS_FS
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index e8325eaa0fd8..a2a5ea945482 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -11,16 +11,10 @@
 
 static void erofs_readendio(struct bio *bio)
 {
-	struct super_block *const sb = bio->bi_private;
 	struct bio_vec *bvec;
 	blk_status_t err = bio->bi_status;
 	struct bvec_iter_all iter_all;
 
-	if (time_to_inject(EROFS_SB(sb), FAULT_READ_IO)) {
-		erofs_show_injection_info(FAULT_READ_IO);
-		err = BLK_STS_IOERR;
-	}
-
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		struct page *page = bvec->bv_page;
 
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 7da5a41f82e3..fcc16d2d10cb 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -127,11 +127,10 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
 			      unsigned int m_pofs)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
-	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
 
 	/* if it can be handled with fast symlink scheme */
 	if (is_inode_flat_inline(inode) && inode->i_size < PAGE_SIZE) {
-		char *lnk = erofs_kmalloc(sbi, inode->i_size + 1, GFP_KERNEL);
+		char *lnk = kmalloc(inode->i_size + 1, GFP_KERNEL);
 
 		if (!lnk)
 			return -ENOMEM;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4a35a31fd454..f5fb5ba52fe2 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -32,23 +32,6 @@
 #define DBG_BUGON(x)            ((void)(x))
 #endif	/* !CONFIG_EROFS_FS_DEBUG */
 
-enum {
-	FAULT_KMALLOC,
-	FAULT_READ_IO,
-	FAULT_MAX,
-};
-
-#ifdef CONFIG_EROFS_FAULT_INJECTION
-extern const char *erofs_fault_name[FAULT_MAX];
-#define IS_FAULT_SET(fi, type) ((fi)->inject_type & (1 << (type)))
-
-struct erofs_fault_info {
-	atomic_t inject_ops;
-	unsigned int inject_rate;
-	unsigned int inject_type;
-};
-#endif	/* CONFIG_EROFS_FAULT_INJECTION */
-
 /* EROFS_SUPER_MAGIC_V1 to represent the whole file system */
 #define EROFS_SUPER_MAGIC   EROFS_SUPER_MAGIC_V1
 
@@ -99,62 +82,14 @@ struct erofs_sb_info {
 	u32 requirements;
 
 	unsigned int mount_opt;
-
-#ifdef CONFIG_EROFS_FAULT_INJECTION
-	struct erofs_fault_info fault_info;	/* For fault injection */
-#endif
 };
 
-#ifdef CONFIG_EROFS_FAULT_INJECTION
-#define erofs_show_injection_info(type)					\
-	infoln("inject %s in %s of %pS", erofs_fault_name[type],        \
-		__func__, __builtin_return_address(0))
-
-static inline bool time_to_inject(struct erofs_sb_info *sbi, int type)
-{
-	struct erofs_fault_info *ffi = &sbi->fault_info;
-
-	if (!ffi->inject_rate)
-		return false;
-
-	if (!IS_FAULT_SET(ffi, type))
-		return false;
-
-	atomic_inc(&ffi->inject_ops);
-	if (atomic_read(&ffi->inject_ops) >= ffi->inject_rate) {
-		atomic_set(&ffi->inject_ops, 0);
-		return true;
-	}
-	return false;
-}
-#else
-static inline bool time_to_inject(struct erofs_sb_info *sbi, int type)
-{
-	return false;
-}
-
-static inline void erofs_show_injection_info(int type)
-{
-}
-#endif	/* !CONFIG_EROFS_FAULT_INJECTION */
-
-static inline void *erofs_kmalloc(struct erofs_sb_info *sbi,
-					size_t size, gfp_t flags)
-{
-	if (time_to_inject(sbi, FAULT_KMALLOC)) {
-		erofs_show_injection_info(FAULT_KMALLOC);
-		return NULL;
-	}
-	return kmalloc(size, flags);
-}
-
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
 #define EROFS_I_SB(inode) ((struct erofs_sb_info *)(inode)->i_sb->s_fs_info)
 
 /* Mount flags set via mount options or defaults */
 #define EROFS_MOUNT_XATTR_USER		0x00000010
 #define EROFS_MOUNT_POSIX_ACL		0x00000020
-#define EROFS_MOUNT_FAULT_INJECTION	0x00000040
 
 #define clear_opt(sbi, option)	((sbi)->mount_opt &= ~EROFS_MOUNT_##option)
 #define set_opt(sbi, option)	((sbi)->mount_opt |= EROFS_MOUNT_##option)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 7bdd9f47c4ac..356025d07d04 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -125,63 +125,6 @@ static int erofs_read_superblock(struct super_block *sb)
 	return ret;
 }
 
-#ifdef CONFIG_EROFS_FAULT_INJECTION
-const char *erofs_fault_name[FAULT_MAX] = {
-	[FAULT_KMALLOC]		= "kmalloc",
-	[FAULT_READ_IO]		= "read IO error",
-};
-
-static void __erofs_build_fault_attr(struct erofs_sb_info *sbi,
-				     unsigned int rate)
-{
-	struct erofs_fault_info *ffi = &sbi->fault_info;
-
-	if (rate) {
-		atomic_set(&ffi->inject_ops, 0);
-		ffi->inject_rate = rate;
-		ffi->inject_type = (1 << FAULT_MAX) - 1;
-	} else {
-		memset(ffi, 0, sizeof(struct erofs_fault_info));
-	}
-
-	set_opt(sbi, FAULT_INJECTION);
-}
-
-static int erofs_build_fault_attr(struct erofs_sb_info *sbi,
-				  substring_t *args)
-{
-	int rate = 0;
-
-	if (args->from && match_int(args, &rate))
-		return -EINVAL;
-
-	__erofs_build_fault_attr(sbi, rate);
-	return 0;
-}
-
-static unsigned int erofs_get_fault_rate(struct erofs_sb_info *sbi)
-{
-	return sbi->fault_info.inject_rate;
-}
-#else
-static void __erofs_build_fault_attr(struct erofs_sb_info *sbi,
-				     unsigned int rate)
-{
-}
-
-static int erofs_build_fault_attr(struct erofs_sb_info *sbi,
-				  substring_t *args)
-{
-	infoln("fault_injection options not supported");
-	return 0;
-}
-
-static unsigned int erofs_get_fault_rate(struct erofs_sb_info *sbi)
-{
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_EROFS_FS_ZIP
 static int erofs_build_cache_strategy(struct erofs_sb_info *sbi,
 				      substring_t *args)
@@ -236,7 +179,6 @@ enum {
 	Opt_nouser_xattr,
 	Opt_acl,
 	Opt_noacl,
-	Opt_fault_injection,
 	Opt_cache_strategy,
 	Opt_err
 };
@@ -246,7 +188,6 @@ static match_table_t erofs_tokens = {
 	{Opt_nouser_xattr, "nouser_xattr"},
 	{Opt_acl, "acl"},
 	{Opt_noacl, "noacl"},
-	{Opt_fault_injection, "fault_injection=%u"},
 	{Opt_cache_strategy, "cache_strategy=%s"},
 	{Opt_err, NULL}
 };
@@ -300,11 +241,6 @@ static int erofs_parse_options(struct super_block *sb, char *options)
 			infoln("noacl options not supported");
 			break;
 #endif
-		case Opt_fault_injection:
-			err = erofs_build_fault_attr(EROFS_SB(sb), args);
-			if (err)
-				return err;
-			break;
 		case Opt_cache_strategy:
 			err = erofs_build_cache_strategy(EROFS_SB(sb), args);
 			if (err)
@@ -592,9 +528,6 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 	else
 		seq_puts(seq, ",noacl");
 #endif
-	if (test_opt(sbi, FAULT_INJECTION))
-		seq_printf(seq, ",fault_injection=%u",
-			   erofs_get_fault_rate(sbi));
 #ifdef CONFIG_EROFS_FS_ZIP
 	if (sbi->cache_strategy == EROFS_ZIP_CACHE_DISABLED) {
 		seq_puts(seq, ",cache_strategy=disabled");
@@ -614,7 +547,6 @@ static int erofs_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	unsigned int org_mnt_opt = sbi->mount_opt;
-	unsigned int org_inject_rate = erofs_get_fault_rate(sbi);
 	int err;
 
 	DBG_BUGON(!sb_rdonly(sb));
@@ -630,9 +562,7 @@ static int erofs_remount(struct super_block *sb, int *flags, char *data)
 	*flags |= SB_RDONLY;
 	return 0;
 out:
-	__erofs_build_fault_attr(sbi, org_inject_rate);
 	sbi->mount_opt = org_mnt_opt;
-
 	return err;
 }
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 3af040c608f1..f772f07c57ed 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -724,15 +724,9 @@ static inline void z_erofs_vle_read_endio(struct bio *bio)
 		DBG_BUGON(PageUptodate(page));
 		DBG_BUGON(!page->mapping);
 
-		if (!sbi && !z_erofs_page_is_staging(page)) {
+		if (!sbi && !z_erofs_page_is_staging(page))
 			sbi = EROFS_SB(page->mapping->host->i_sb);
 
-			if (time_to_inject(sbi, FAULT_READ_IO)) {
-				erofs_show_injection_info(FAULT_READ_IO);
-				err = BLK_STS_IOERR;
-			}
-		}
-
 		/* sbi should already be gotten if the page is managed */
 		if (sbi)
 			cachemngd = erofs_page_is_managed(sbi, page);
-- 
2.17.1

