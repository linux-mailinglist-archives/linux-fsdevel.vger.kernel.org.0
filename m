Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48A3F16F817
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 07:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgBZGhv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 01:37:51 -0500
Received: from mx04.melco.co.jp ([192.218.140.144]:56364 "EHLO
        mx04.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgBZGhv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 01:37:51 -0500
Received: from mr04.melco.co.jp (mr04 [133.141.98.166])
        by mx04.melco.co.jp (Postfix) with ESMTP id 4DA743A419B;
        Wed, 26 Feb 2020 15:37:49 +0900 (JST)
Received: from mr04.melco.co.jp (unknown [127.0.0.1])
        by mr04.imss (Postfix) with ESMTP id 48S5hY139lzRkGJ;
        Wed, 26 Feb 2020 15:37:49 +0900 (JST)
Received: from mf04_second.melco.co.jp (unknown [192.168.20.184])
        by mr04.melco.co.jp (Postfix) with ESMTP id 48S5hY0kljzRk96;
        Wed, 26 Feb 2020 15:37:49 +0900 (JST)
Received: from mf04.melco.co.jp (unknown [133.141.98.184])
        by mf04_second.melco.co.jp (Postfix) with ESMTP id 48S5hY0hqBzRkC0;
        Wed, 26 Feb 2020 15:37:49 +0900 (JST)
Received: from tux532.tad.melco.co.jp (unknown [133.141.243.226])
        by mf04.melco.co.jp (Postfix) with ESMTP id 48S5hY07KZzRk7V;
        Wed, 26 Feb 2020 15:37:49 +0900 (JST)
Received:  from tux532.tad.melco.co.jp
        by tux532.tad.melco.co.jp (unknown) with ESMTP id 01Q6bmYY020894;
        Wed, 26 Feb 2020 15:37:48 +0900
Received: from tux390.tad.melco.co.jp (tux390.tad.melco.co.jp [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id A1CB817E075;
        Wed, 26 Feb 2020 15:37:48 +0900 (JST)
Received: from tux554.tad.melco.co.jp (mailgw1.tad.melco.co.jp [10.168.7.223])
        by tux390.tad.melco.co.jp (Postfix) with ESMTP id 8905917E073;
        Wed, 26 Feb 2020 15:37:48 +0900 (JST)
Received: from tux554.tad.melco.co.jp
        by tux554.tad.melco.co.jp (unknown) with ESMTP id 01Q6bmFI029214;
        Wed, 26 Feb 2020 15:37:48 +0900
From:   Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: exfat: remove symlink feature : Additional patch
Date:   Wed, 26 Feb 2020 15:37:46 +0900
Message-Id: <20200226063746.3128-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Completely remove symlink codes and definitions.
In the previous patch, it was not completely removed.

Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
---
 drivers/staging/exfat/exfat.h       |  3 ---
 drivers/staging/exfat/exfat_core.c  |  3 ---
 drivers/staging/exfat/exfat_super.c | 27 ---------------------------
 3 files changed, 33 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 4a0a481fe010..cd3479fc78ba 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -63,7 +63,6 @@
 #define TYPE_VOLUME		0x0103
 #define TYPE_DIR		0x0104
 #define TYPE_FILE		0x011F
-#define TYPE_SYMLINK		0x015F
 #define TYPE_CRITICAL_SEC	0x0200
 #define TYPE_STREAM		0x0201
 #define TYPE_EXTEND		0x0202
@@ -198,13 +197,11 @@ static inline u16 get_row_index(u16 i)
 #define ATTR_VOLUME		0x0008
 #define ATTR_SUBDIR		0x0010
 #define ATTR_ARCHIVE		0x0020
-#define ATTR_SYMLINK		0x0040
 #define ATTR_EXTEND		0x000F
 #define ATTR_RWMASK		0x007E
 
 /* file creation modes */
 #define FM_REGULAR              0x00
-#define FM_SYMLINK              0x40
 
 #define NUM_UPCASE              2918
 
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index d30dc050411e..941094b08dd9 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -844,9 +844,6 @@ static void exfat_set_entry_type(struct dentry_t *p_entry, u32 type)
 	} else if (type == TYPE_FILE) {
 		ep->type = 0x85;
 		SET16_A(ep->attr, ATTR_ARCHIVE);
-	} else if (type == TYPE_SYMLINK) {
-		ep->type = 0x85;
-		SET16_A(ep->attr, ATTR_ARCHIVE | ATTR_SYMLINK);
 	}
 }
 
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index c7bc07e91c45..6f3b72eb999d 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -320,8 +320,6 @@ static inline mode_t exfat_make_mode(struct exfat_sb_info *sbi, u32 attr,
 
 	if (attr & ATTR_SUBDIR)
 		return (mode & ~sbi->options.fs_dmask) | S_IFDIR;
-	else if (attr & ATTR_SYMLINK)
-		return (mode & ~sbi->options.fs_dmask) | S_IFLNK;
 	else
 		return (mode & ~sbi->options.fs_fmask) | S_IFREG;
 }
@@ -2399,24 +2397,6 @@ static const struct inode_operations exfat_dir_inode_operations = {
 /*======================================================================*/
 /*  File Operations                                                     */
 /*======================================================================*/
-static const char *exfat_get_link(struct dentry *dentry, struct inode *inode,
-				  struct delayed_call *done)
-{
-	struct exfat_inode_info *ei = EXFAT_I(inode);
-
-	if (ei->target) {
-		char *cookie = ei->target;
-
-		if (cookie)
-			return (char *)(ei->target);
-	}
-	return NULL;
-}
-
-static const struct inode_operations exfat_symlink_inode_operations = {
-		.get_link = exfat_get_link,
-};
-
 static int exfat_file_release(struct inode *inode, struct file *filp)
 {
 	struct super_block *sb = inode->i_sb;
@@ -2688,13 +2668,6 @@ static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
 		i_size_write(inode, info.Size);
 		EXFAT_I(inode)->mmu_private = i_size_read(inode);
 		set_nlink(inode, info.num_subdirs);
-	} else if (info.attr & ATTR_SYMLINK) { /* symbolic link */
-		inode->i_generation |= 1;
-		inode->i_mode = exfat_make_mode(sbi, info.attr, 0777);
-		inode->i_op = &exfat_symlink_inode_operations;
-
-		i_size_write(inode, info.Size);
-		EXFAT_I(inode)->mmu_private = i_size_read(inode);
 	} else { /* regular file */
 		inode->i_generation |= 1;
 		inode->i_mode = exfat_make_mode(sbi, info.attr, 0777);
-- 
2.25.1

