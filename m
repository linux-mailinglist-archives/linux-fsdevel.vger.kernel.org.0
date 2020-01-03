Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24B4D12F2A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 02:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgACBRP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 20:17:15 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:30214 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgACBRP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:17:15 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200103011710epoutp01e822a2ede898a51366666b03d09db649~mO5TvRsHi1563915639epoutp01I
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jan 2020 01:17:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200103011710epoutp01e822a2ede898a51366666b03d09db649~mO5TvRsHi1563915639epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578014230;
        bh=Hq+W8EsQWGrVHW3Cr5DoY9AOxIarWUa66nhaKRJtZB8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=PivFhJWMSsEoowtTFE1aYG8/O3X56vwuBH3nwLbkAmel/2aAWjYDv42CdD9Qeuywk
         5Vd2RU4/LyZSl9X0OaSQoNJ77M5a/RHpNMQN/vPgLGbwTy2b9qFqhbkWmsxYg7GbTg
         VtnfFLGZRuRqO+Z18qAc7EUyhJjQUraShXOOX5Uk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200103011709epcas1p4e1f76239c591ce0a382ec9a4737b3b13~mO5TY6C_N2399623996epcas1p4d;
        Fri,  3 Jan 2020 01:17:09 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.161]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47pn7S6y0XzMqYkV; Fri,  3 Jan
        2020 01:17:08 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.43.52419.4169E0E5; Fri,  3 Jan 2020 10:17:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200103011708epcas1p3be094a9c7cf7b633f7b5d9c404d16ea5~mO5SNcGHm1588015880epcas1p3X;
        Fri,  3 Jan 2020 01:17:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200103011708epsmtrp1c3278d28a41bc5ef44bfff8eab38d2a5~mO5SMru3z1308913089epsmtrp1Z;
        Fri,  3 Jan 2020 01:17:08 +0000 (GMT)
X-AuditID: b6c32a37-a10cb9c00001ccc3-83-5e0e96146118
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.7B.10238.4169E0E5; Fri,  3 Jan 2020 10:17:08 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200103011708epsmtip154fa03f4e5ca56d1b5ef2407a4e46665~mO5SDXVGK0375203752epsmtip1Q;
        Fri,  3 Jan 2020 01:17:08 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH] staging: exfat: add STAGING prefix to config names
Date:   Fri,  3 Jan 2020 09:13:45 +0800
Message-Id: <20200103011345.25245-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCKsWRmVeSWpSXmKPExsWy7bCmnq7INL44g1vdVhZ7zvxit2hevJ7N
        Ys/ekywWl3fNYbP4Mb3e4tL7DywObB739h1m8dg/dw27R9+WVYwenzfJeRza/oYtgDUqxyYj
        NTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AAlhbLEnFKg
        UEBicbGSvp1NUX5pSapCRn5xia1SakFKToGhQYFecWJucWleul5yfq6VoYGBkSlQZUJOxokn
        pxgLThRWNPxuYWlgbIrvYuTkkBAwkTh5dyZ7FyMXh5DADkaJD0tuQjmfGCVevH/AAuF8Y5Q4
        s6+PCabl0P6JUIm9QFV3L7CBJMBabs1X6mLk4GAT0Jb4s0UUJCwiYC6x+9J1VpB6ZoEWRonb
        nz+yg9QICzhLbPyoA1LDIqAqsf7DREaQMK+AjcSWySoQq+QlVm84wAzSKiHwl1ViRW8jO0TC
        RWLO+bdQ9whLvDq+BSouJfGyvw1svIRAtcTH/cwQ4Q6gM7/bQtjGEjfXb2AFKWEW0JRYv0sf
        IqwosfP3XEYQm1mAT+Ld1x5WiCm8Eh1tQhAlqhJ9lw5DLZWW6Gr/ALXUQ+L0hk0skDCIlfj2
        uoV5AqPsLIQFCxgZVzGKpRYU56anFhsWGCPH0CZGcIrSMt/BuOGczyFGAQ5GJR7eCdd444RY
        E8uKK3MPMUpwMCuJ8JYHAoV4UxIrq1KL8uOLSnNSiw8xmgKDbiKzlGhyPjB95pXEG5oaGRsb
        W5iYmZuZGiuJ83L8uBgrJJCeWJKanZpakFoE08fEwSnVwMjVszzjlFNgtkGNXMSzO9tiovht
        zokFthqv3CV3yvSz9G3XkpWrg3yKTZ6xOu0SSrD9czGxfQV7w9c3t3rW9E6OWH5JWz/2UePy
        i43MwVbPj8ioq2n2vqv7/mqZzIZu+6ICn4nRrYeZ56TZeojoZCwPuS6XzXD9QvtVT6mXJrxN
        NfLLWK8qKrEUZyQaajEXFScCAMKl79BnAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmluLIzCtJLcpLzFFi42LZdlhJTldkGl+cwYfdyhZ7zvxit2hevJ7N
        Ys/ekywWl3fNYbP4Mb3e4tL7DywObB739h1m8dg/dw27R9+WVYwenzfJeRza/oYtgDWKyyYl
        NSezLLVI3y6BK+PEk1OMBScKKxp+t7A0MDbFdzFyckgImEgc2j+RpYuRi0NIYDejxNKbS5gg
        EtISx06cYe5i5ACyhSUOHy6GqPnAKHHn5DwWkDibgLbEny2iIOUiApYSU+//ZgepYRboYJT4
        MecCI0iNsICzxMaPOiA1LAKqEus/TAQL8wrYSGyZrAKxSV5i9YYDzBMYeRYwMqxilEwtKM5N
        zy02LDDMSy3XK07MLS7NS9dLzs/dxAgOGi3NHYyXl8QfYhTgYFTi4Z1wjTdOiDWxrLgy9xCj
        BAezkghveSBQiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/TvGORQgLpiSWp2ampBalFMFkmDk6p
        Bsa+yI8h+sw718rZhJnPv9nfffX+5Ozlu2UkjP7GZ6fPaIrXD976c6eKrO6qi9aHerpja68e
        uXuBr9vjhULtmnreiyd3XWSWO8m51M9R7U3ln611B8za7h08+rFeRtxVNXjJFXGWMzGlZdOn
        qM/70fh85ubCEO9dxwyff101a6lF5ZKP0hN3K6kosRRnJBpqMRcVJwIAswKBlhYCAAA=
X-CMS-MailID: 20200103011708epcas1p3be094a9c7cf7b633f7b5d9c404d16ea5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200103011708epcas1p3be094a9c7cf7b633f7b5d9c404d16ea5
References: <CGME20200103011708epcas1p3be094a9c7cf7b633f7b5d9c404d16ea5@epcas1p3.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add STAGING prefix to config names to avoid collsion with fs/exfat config.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
---
 drivers/staging/Makefile             |  2 +-
 drivers/staging/exfat/Kconfig        | 26 +++++++--------
 drivers/staging/exfat/Makefile       |  2 +-
 drivers/staging/exfat/exfat.h        | 14 ++++----
 drivers/staging/exfat/exfat_blkdev.c | 12 +++----
 drivers/staging/exfat/exfat_core.c   |  8 ++---
 drivers/staging/exfat/exfat_super.c  | 50 ++++++++++++++--------------
 7 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 463aef6a18ef..fdd03fd6e704 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -48,7 +48,7 @@ obj-$(CONFIG_FIELDBUS_DEV)     += fieldbus/
 obj-$(CONFIG_KPC2000)		+= kpc2000/
 obj-$(CONFIG_UWB)		+= uwb/
 obj-$(CONFIG_USB_WUSB)		+= wusbcore/
-obj-$(CONFIG_EXFAT_FS)		+= exfat/
+obj-$(CONFIG_STAGING_EXFAT_FS)	+= exfat/
 obj-$(CONFIG_QLGE)		+= qlge/
 obj-$(CONFIG_NET_VENDOR_HP)	+= hp/
 obj-$(CONFIG_WFX)		+= wfx/
diff --git a/drivers/staging/exfat/Kconfig b/drivers/staging/exfat/Kconfig
index 0130019cbec2..292a19dfcaf5 100644
--- a/drivers/staging/exfat/Kconfig
+++ b/drivers/staging/exfat/Kconfig
@@ -1,41 +1,41 @@
 # SPDX-License-Identifier: GPL-2.0
-config EXFAT_FS
+config STAGING_EXFAT_FS
 	tristate "exFAT fs support"
 	depends on BLOCK
 	select NLS
 	help
 	  This adds support for the exFAT file system.
 
-config EXFAT_DISCARD
+config STAGING_EXFAT_DISCARD
 	bool "enable discard support"
-	depends on EXFAT_FS
+	depends on STAGING_EXFAT_FS
 	default y
 
-config EXFAT_DELAYED_SYNC
+config STAGING_EXFAT_DELAYED_SYNC
 	bool "enable delayed sync"
-	depends on EXFAT_FS
+	depends on STAGING_EXFAT_FS
 	default n
 
-config EXFAT_KERNEL_DEBUG
+config STAGING_EXFAT_KERNEL_DEBUG
 	bool "enable kernel debug features via ioctl"
-	depends on EXFAT_FS
+	depends on STAGING_EXFAT_FS
 	default n
 
-config EXFAT_DEBUG_MSG
+config STAGING_EXFAT_DEBUG_MSG
 	bool "print debug messages"
-	depends on EXFAT_FS
+	depends on STAGING_EXFAT_FS
 	default n
 
-config EXFAT_DEFAULT_CODEPAGE
+config STAGING_EXFAT_DEFAULT_CODEPAGE
 	int "Default codepage for exFAT"
 	default 437
-	depends on EXFAT_FS
+	depends on STAGING_EXFAT_FS
 	help
 	  This option should be set to the codepage of your exFAT filesystems.
 
-config EXFAT_DEFAULT_IOCHARSET
+config STAGING_EXFAT_DEFAULT_IOCHARSET
 	string "Default iocharset for exFAT"
 	default "utf8"
-	depends on EXFAT_FS
+	depends on STAGING_EXFAT_FS
 	help
 	  Set this to the default input/output character set you'd like exFAT to use.
diff --git a/drivers/staging/exfat/Makefile b/drivers/staging/exfat/Makefile
index 6c90aec83feb..057556eeca0c 100644
--- a/drivers/staging/exfat/Makefile
+++ b/drivers/staging/exfat/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-obj-$(CONFIG_EXFAT_FS) += exfat.o
+obj-$(CONFIG_STAGING_EXFAT_FS) += exfat.o
 
 exfat-y :=	exfat_core.o	\
 		exfat_super.o	\
diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 51c665a924b7..3865c17027ce 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -9,7 +9,7 @@
 #include <linux/types.h>
 #include <linux/buffer_head.h>
 
-#ifdef CONFIG_EXFAT_KERNEL_DEBUG
+#ifdef CONFIG_STAGING_EXFAT_KERNEL_DEBUG
   /* For Debugging Purpose */
 	/* IOCTL code 'f' used by
 	 *   - file systems typically #0~0x1F
@@ -22,9 +22,9 @@
 
 #define EXFAT_DEBUGFLAGS_INVALID_UMOUNT	0x01
 #define EXFAT_DEBUGFLAGS_ERROR_RW	0x02
-#endif /* CONFIG_EXFAT_KERNEL_DEBUG */
+#endif /* CONFIG_STAGING_EXFAT_KERNEL_DEBUG */
 
-#ifdef CONFIG_EXFAT_DEBUG_MSG
+#ifdef CONFIG_STAGING_EXFAT_DEBUG_MSG
 #define DEBUG	1
 #else
 #undef DEBUG
@@ -661,10 +661,10 @@ struct exfat_mount_options {
 
 	/* on error: continue, panic, remount-ro */
 	unsigned char errors;
-#ifdef CONFIG_EXFAT_DISCARD
+#ifdef CONFIG_STAGING_EXFAT_DISCARD
 	/* flag on if -o dicard specified and device support discard() */
 	unsigned char discard;
-#endif /* CONFIG_EXFAT_DISCARD */
+#endif /* CONFIG_STAGING_EXFAT_DISCARD */
 };
 
 #define EXFAT_HASH_BITS		8
@@ -700,9 +700,9 @@ struct exfat_sb_info {
 
 	spinlock_t inode_hash_lock;
 	struct hlist_head inode_hashtable[EXFAT_HASH_SIZE];
-#ifdef CONFIG_EXFAT_KERNEL_DEBUG
+#ifdef CONFIG_STAGING_EXFAT_KERNEL_DEBUG
 	long debug_flags;
-#endif /* CONFIG_EXFAT_KERNEL_DEBUG */
+#endif /* CONFIG_STAGING_EXFAT_KERNEL_DEBUG */
 };
 
 /*
diff --git a/drivers/staging/exfat/exfat_blkdev.c b/drivers/staging/exfat/exfat_blkdev.c
index 7bcd98b13109..8791a5f2bb08 100644
--- a/drivers/staging/exfat/exfat_blkdev.c
+++ b/drivers/staging/exfat/exfat_blkdev.c
@@ -35,13 +35,13 @@ int exfat_bdev_read(struct super_block *sb, sector_t secno, struct buffer_head *
 {
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-#ifdef CONFIG_EXFAT_KERNEL_DEBUG
+#ifdef CONFIG_STAGING_EXFAT_KERNEL_DEBUG
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	long flags = sbi->debug_flags;
 
 	if (flags & EXFAT_DEBUGFLAGS_ERROR_RW)
 		return -EIO;
-#endif /* CONFIG_EXFAT_KERNEL_DEBUG */
+#endif /* CONFIG_STAGING_EXFAT_KERNEL_DEBUG */
 
 	if (!p_bd->opened)
 		return -ENODEV;
@@ -72,13 +72,13 @@ int exfat_bdev_write(struct super_block *sb, sector_t secno, struct buffer_head
 	struct buffer_head *bh2;
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-#ifdef CONFIG_EXFAT_KERNEL_DEBUG
+#ifdef CONFIG_STAGING_EXFAT_KERNEL_DEBUG
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	long flags = sbi->debug_flags;
 
 	if (flags & EXFAT_DEBUGFLAGS_ERROR_RW)
 		return -EIO;
-#endif /* CONFIG_EXFAT_KERNEL_DEBUG */
+#endif /* CONFIG_STAGING_EXFAT_KERNEL_DEBUG */
 
 	if (!p_bd->opened)
 		return -ENODEV;
@@ -121,13 +121,13 @@ int exfat_bdev_write(struct super_block *sb, sector_t secno, struct buffer_head
 int exfat_bdev_sync(struct super_block *sb)
 {
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
-#ifdef CONFIG_EXFAT_KERNEL_DEBUG
+#ifdef CONFIG_STAGING_EXFAT_KERNEL_DEBUG
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	long flags = sbi->debug_flags;
 
 	if (flags & EXFAT_DEBUGFLAGS_ERROR_RW)
 		return -EIO;
-#endif /* CONFIG_EXFAT_KERNEL_DEBUG */
+#endif /* CONFIG_STAGING_EXFAT_KERNEL_DEBUG */
 
 	if (!p_bd->opened)
 		return -ENODEV;
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 794000e7bc6f..5e7645fe8c45 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -177,11 +177,11 @@ static s32 clr_alloc_bitmap(struct super_block *sb, u32 clu)
 {
 	int i, b;
 	sector_t sector;
-#ifdef CONFIG_EXFAT_DISCARD
+#ifdef CONFIG_STAGING_EXFAT_DISCARD
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_mount_options *opts = &sbi->options;
 	int ret;
-#endif /* CONFIG_EXFAT_DISCARD */
+#endif /* CONFIG_STAGING_EXFAT_DISCARD */
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 
@@ -192,7 +192,7 @@ static s32 clr_alloc_bitmap(struct super_block *sb, u32 clu)
 
 	exfat_bitmap_clear((u8 *)p_fs->vol_amap[i]->b_data, b);
 
-#ifdef CONFIG_EXFAT_DISCARD
+#ifdef CONFIG_STAGING_EXFAT_DISCARD
 	if (opts->discard) {
 		ret = sb_issue_discard(sb, START_SECTOR(clu),
 				       (1 << p_fs->sectors_per_clu_bits),
@@ -204,7 +204,7 @@ static s32 clr_alloc_bitmap(struct super_block *sb, u32 clu)
 			return ret;
 		}
 	}
-#endif /* CONFIG_EXFAT_DISCARD */
+#endif /* CONFIG_STAGING_EXFAT_DISCARD */
 
 	return sector_write(sb, sector, p_fs->vol_amap[i], 0);
 }
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 744344a2521c..9fa2ad3627c5 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -38,8 +38,8 @@
 
 static struct kmem_cache *exfat_inode_cachep;
 
-static int exfat_default_codepage = CONFIG_EXFAT_DEFAULT_CODEPAGE;
-static char exfat_default_iocharset[] = CONFIG_EXFAT_DEFAULT_IOCHARSET;
+static int exfat_default_codepage = CONFIG_STAGING_EXFAT_DEFAULT_CODEPAGE;
+static char exfat_default_iocharset[] = CONFIG_STAGING_EXFAT_DEFAULT_IOCHARSET;
 
 #define INC_IVERSION(x) (inode_inc_iversion(x))
 #define GET_IVERSION(x) (inode_peek_iversion_raw(x))
@@ -647,7 +647,7 @@ static int ffsCreateFile(struct inode *inode, char *path, u8 mode,
 	/* create a new file */
 	ret = create_file(inode, &dir, &uni_name, mode, fid);
 
-#ifndef CONFIG_EXFAT_DELAYED_SYNC
+#ifndef CONFIG_STAGING_EXFAT_DELAYED_SYNC
 	fs_sync(sb, true);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
@@ -1008,7 +1008,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 	update_dir_checksum_with_entry_set(sb, es);
 	release_entry_set(es);
 
-#ifndef CONFIG_EXFAT_DELAYED_SYNC
+#ifndef CONFIG_STAGING_EXFAT_DELAYED_SYNC
 	fs_sync(sb, true);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
@@ -1134,7 +1134,7 @@ static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 	if (fid->rwoffset > fid->size)
 		fid->rwoffset = fid->size;
 
-#ifndef CONFIG_EXFAT_DELAYED_SYNC
+#ifndef CONFIG_STAGING_EXFAT_DELAYED_SYNC
 	fs_sync(sb, true);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
@@ -1282,7 +1282,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 						num_entries + 1);
 	}
 out:
-#ifndef CONFIG_EXFAT_DELAYED_SYNC
+#ifndef CONFIG_STAGING_EXFAT_DELAYED_SYNC
 	fs_sync(sb, true);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
@@ -1344,7 +1344,7 @@ static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
 	fid->start_clu = CLUSTER_32(~0);
 	fid->flags = (p_fs->vol_type == EXFAT) ? 0x03 : 0x01;
 
-#ifndef CONFIG_EXFAT_DELAYED_SYNC
+#ifndef CONFIG_STAGING_EXFAT_DELAYED_SYNC
 	fs_sync(sb, true);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
@@ -1420,7 +1420,7 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 	update_dir_checksum_with_entry_set(sb, es);
 	release_entry_set(es);
 
-#ifndef CONFIG_EXFAT_DELAYED_SYNC
+#ifndef CONFIG_STAGING_EXFAT_DELAYED_SYNC
 	fs_sync(sb, true);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
@@ -1804,7 +1804,7 @@ static int ffsCreateDir(struct inode *inode, char *path, struct file_id_t *fid)
 
 	ret = create_dir(inode, &dir, &uni_name, fid);
 
-#ifndef CONFIG_EXFAT_DELAYED_SYNC
+#ifndef CONFIG_STAGING_EXFAT_DELAYED_SYNC
 	fs_sync(sb, true);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
@@ -2053,7 +2053,7 @@ static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
 	fid->start_clu = CLUSTER_32(~0);
 	fid->flags = (p_fs->vol_type == EXFAT) ? 0x03 : 0x01;
 
-#ifndef CONFIG_EXFAT_DELAYED_SYNC
+#ifndef CONFIG_STAGING_EXFAT_DELAYED_SYNC
 	fs_sync(sb, true);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
@@ -2176,14 +2176,14 @@ static long exfat_generic_ioctl(struct file *filp, unsigned int cmd,
 				unsigned long arg)
 {
 	struct inode *inode = filp->f_path.dentry->d_inode;
-#ifdef CONFIG_EXFAT_KERNEL_DEBUG
+#ifdef CONFIG_STAGING_EXFAT_KERNEL_DEBUG
 	unsigned int flags;
-#endif /* CONFIG_EXFAT_KERNEL_DEBUG */
+#endif /* CONFIG_STAGING_EXFAT_KERNEL_DEBUG */
 
 	switch (cmd) {
 	case EXFAT_IOCTL_GET_VOLUME_ID:
 		return exfat_ioctl_volume_id(inode);
-#ifdef CONFIG_EXFAT_KERNEL_DEBUG
+#ifdef CONFIG_STAGING_EXFAT_KERNEL_DEBUG
 	case EXFAT_IOC_GET_DEBUGFLAGS: {
 		struct super_block *sb = inode->i_sb;
 		struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -2207,7 +2207,7 @@ static long exfat_generic_ioctl(struct file *filp, unsigned int cmd,
 
 		return 0;
 	}
-#endif /* CONFIG_EXFAT_KERNEL_DEBUG */
+#endif /* CONFIG_STAGING_EXFAT_KERNEL_DEBUG */
 	default:
 		return -ENOTTY; /* Inappropriate ioctl for device */
 	}
@@ -3400,7 +3400,7 @@ static int exfat_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",errors=panic");
 	else
 		seq_puts(m, ",errors=remount-ro");
-#ifdef CONFIG_EXFAT_DISCARD
+#ifdef CONFIG_STAGING_EXFAT_DISCARD
 	if (opts->discard)
 		seq_puts(m, ",discard");
 #endif
@@ -3481,7 +3481,7 @@ enum {
 	Opt_err_ro,
 	Opt_utf8_hack,
 	Opt_err,
-#ifdef CONFIG_EXFAT_DISCARD
+#ifdef CONFIG_STAGING_EXFAT_DISCARD
 	Opt_discard,
 #endif /* EXFAT_CONFIG_DISCARD */
 };
@@ -3501,9 +3501,9 @@ static const match_table_t exfat_tokens = {
 	{Opt_err_panic, "errors=panic"},
 	{Opt_err_ro, "errors=remount-ro"},
 	{Opt_utf8_hack, "utf8"},
-#ifdef CONFIG_EXFAT_DISCARD
+#ifdef CONFIG_STAGING_EXFAT_DISCARD
 	{Opt_discard, "discard"},
-#endif /* CONFIG_EXFAT_DISCARD */
+#endif /* CONFIG_STAGING_EXFAT_DISCARD */
 	{Opt_err, NULL}
 };
 
@@ -3524,7 +3524,7 @@ static int parse_options(char *options, int silent, int *debug,
 	opts->iocharset = exfat_default_iocharset;
 	opts->casesensitive = 0;
 	opts->errors = EXFAT_ERRORS_RO;
-#ifdef CONFIG_EXFAT_DISCARD
+#ifdef CONFIG_STAGING_EXFAT_DISCARD
 	opts->discard = 0;
 #endif
 	*debug = 0;
@@ -3595,11 +3595,11 @@ static int parse_options(char *options, int silent, int *debug,
 		case Opt_debug:
 			*debug = 1;
 			break;
-#ifdef CONFIG_EXFAT_DISCARD
+#ifdef CONFIG_STAGING_EXFAT_DISCARD
 		case Opt_discard:
 			opts->discard = 1;
 			break;
-#endif /* CONFIG_EXFAT_DISCARD */
+#endif /* CONFIG_STAGING_EXFAT_DISCARD */
 		case Opt_utf8_hack:
 			break;
 		default:
@@ -3803,7 +3803,7 @@ static void __exit exfat_destroy_inodecache(void)
 	kmem_cache_destroy(exfat_inode_cachep);
 }
 
-#ifdef CONFIG_EXFAT_KERNEL_DEBUG
+#ifdef CONFIG_STAGING_EXFAT_KERNEL_DEBUG
 static void exfat_debug_kill_sb(struct super_block *sb)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -3831,17 +3831,17 @@ static void exfat_debug_kill_sb(struct super_block *sb)
 
 	kill_block_super(sb);
 }
-#endif /* CONFIG_EXFAT_KERNEL_DEBUG */
+#endif /* CONFIG_STAGING_EXFAT_KERNEL_DEBUG */
 
 static struct file_system_type exfat_fs_type = {
 	.owner       = THIS_MODULE,
 	.name        = "exfat",
 	.mount       = exfat_fs_mount,
-#ifdef CONFIG_EXFAT_KERNEL_DEBUG
+#ifdef CONFIG_STAGING_EXFAT_KERNEL_DEBUG
 	.kill_sb    = exfat_debug_kill_sb,
 #else
 	.kill_sb    = kill_block_super,
-#endif /* CONFIG_EXFAT_KERNEL_DEBUG */
+#endif /* CONFIG_STAGING_EXFAT_KERNEL_DEBUG */
 	.fs_flags    = FS_REQUIRES_DEV,
 };
 
-- 
2.17.1

