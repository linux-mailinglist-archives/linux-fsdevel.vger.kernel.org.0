Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8D64E3729
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 17:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503369AbfJXPyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 11:54:51 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:43036 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2503361AbfJXPyu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:54:50 -0400
Received: from mr1.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFsmj2010476
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:48 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFshTd023841
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:48 -0400
Received: by mail-qt1-f199.google.com with SMTP id m19so25500610qtm.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 08:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KtRQDA7GVkdD6y8xrEWINizWdATLMGr42tBTsdyxqPc=;
        b=nyYfQt5MSraRG0cWOlL7LOnGEVppY4EQ2E+TXsB+baKig4KQ+ylU4EYhBX+d+vXpV/
         SFJ7CR24mtXzIBR/D2RqwwkBECcFbZepDof3vuTi9b/IvSkBi0DF4inYX7keH5O4aRLg
         zU7iXJpgPK9iyPKUawZHnepUTZbnLJbBs7/WxORe+6rg5H+Ww4FazEJ+SZzulCBxVavR
         USm9mbV/L853jkqNNtgignPXwEKAHeYUG0eqjHE2D+n3kAb+OrucmCAN6NDtFBHO00qX
         vnfp47sLZXwvvgk2XCDZKhCkChQHcic5LAxSUA/PI1WyehkgSdHqQYizvGkPglrdVcNj
         bVlw==
X-Gm-Message-State: APjAAAUkYdu8Z0BV8gROQMMKEPkEUV/h0iv5HXkou30dlG+wl6uQrD0P
        aSpRpGWggJFH7h1UrtMyp0qHnKDvLVrJoH5njExPJewunZ2a5PjOGiLjdiDDu63x61u8QyMo6cy
        DBJdfhfIPwdkJNqcxXKKuVVuXeH1Uz3bFv/Zf
X-Received: by 2002:ac8:70cf:: with SMTP id g15mr4829450qtp.79.1571932483024;
        Thu, 24 Oct 2019 08:54:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz9GPO8yU44lVTrRFxvuRy7gFATWy/74bFGATrgblYNAnVcwmXLcDQLbxQc75SQw5txMavRKw==
X-Received: by 2002:ac8:70cf:: with SMTP id g15mr4829344qtp.79.1571932481838;
        Thu, 24 Oct 2019 08:54:41 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:40 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] staging: exfat: Clean up return codes - FFS_MEDIAERR
Date:   Thu, 24 Oct 2019 11:53:21 -0400
Message-Id: <20191024155327.1095907-11-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert FFS_MEDIAERR to (mostly) -ENOENT and -EIO.  Some additional code surgery
needed to propogate correct error codes upwards.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h        |   1 -
 drivers/staging/exfat/exfat_blkdev.c |  18 ++---
 drivers/staging/exfat/exfat_core.c   |  68 ++++++++--------
 drivers/staging/exfat/exfat_super.c  | 115 ++++++++++++++-------------
 4 files changed, 101 insertions(+), 101 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 7ca187e77cbe..df7b99707aed 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -210,7 +210,6 @@ static inline u16 get_row_index(u16 i)
 
 /* return values */
 #define FFS_SUCCESS             0
-#define FFS_MEDIAERR            1
 #define FFS_MOUNTED             3
 #define FFS_NOTMOUNTED          4
 #define FFS_ALIGNMENTERR        5
diff --git a/drivers/staging/exfat/exfat_blkdev.c b/drivers/staging/exfat/exfat_blkdev.c
index 81d20e6241c6..0abae041f632 100644
--- a/drivers/staging/exfat/exfat_blkdev.c
+++ b/drivers/staging/exfat/exfat_blkdev.c
@@ -40,11 +40,11 @@ int bdev_read(struct super_block *sb, sector_t secno, struct buffer_head **bh,
 	long flags = sbi->debug_flags;
 
 	if (flags & EXFAT_DEBUGFLAGS_ERROR_RW)
-		return FFS_MEDIAERR;
+		return -EIO;
 #endif /* CONFIG_EXFAT_KERNEL_DEBUG */
 
 	if (!p_bd->opened)
-		return FFS_MEDIAERR;
+		return -ENODEV;
 
 	if (*bh)
 		__brelse(*bh);
@@ -62,7 +62,7 @@ int bdev_read(struct super_block *sb, sector_t secno, struct buffer_head **bh,
 	WARN(!p_fs->dev_ejected,
 	     "[EXFAT] No bh, device seems wrong or to be ejected.\n");
 
-	return FFS_MEDIAERR;
+	return -EIO;
 }
 
 int bdev_write(struct super_block *sb, sector_t secno, struct buffer_head *bh,
@@ -77,11 +77,11 @@ int bdev_write(struct super_block *sb, sector_t secno, struct buffer_head *bh,
 	long flags = sbi->debug_flags;
 
 	if (flags & EXFAT_DEBUGFLAGS_ERROR_RW)
-		return FFS_MEDIAERR;
+		return -EIO;
 #endif /* CONFIG_EXFAT_KERNEL_DEBUG */
 
 	if (!p_bd->opened)
-		return FFS_MEDIAERR;
+		return -ENODEV;
 
 	if (secno == bh->b_blocknr) {
 		lock_buffer(bh);
@@ -89,7 +89,7 @@ int bdev_write(struct super_block *sb, sector_t secno, struct buffer_head *bh,
 		mark_buffer_dirty(bh);
 		unlock_buffer(bh);
 		if (sync && (sync_dirty_buffer(bh) != 0))
-			return FFS_MEDIAERR;
+			return -EIO;
 	} else {
 		count = num_secs << p_bd->sector_size_bits;
 
@@ -115,7 +115,7 @@ int bdev_write(struct super_block *sb, sector_t secno, struct buffer_head *bh,
 	WARN(!p_fs->dev_ejected,
 	     "[EXFAT] No bh, device seems wrong or to be ejected.\n");
 
-	return FFS_MEDIAERR;
+	return -EIO;
 }
 
 int bdev_sync(struct super_block *sb)
@@ -126,11 +126,11 @@ int bdev_sync(struct super_block *sb)
 	long flags = sbi->debug_flags;
 
 	if (flags & EXFAT_DEBUGFLAGS_ERROR_RW)
-		return FFS_MEDIAERR;
+		return -EIO;
 #endif /* CONFIG_EXFAT_KERNEL_DEBUG */
 
 	if (!p_bd->opened)
-		return FFS_MEDIAERR;
+		return -ENODEV;
 
 	return sync_blockdev(sb->s_bdev);
 }
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 39c103e73b63..7e637a8e19d3 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -158,7 +158,7 @@ s32 load_alloc_bitmap(struct super_block *sb)
 			ep = (struct bmap_dentry_t *)get_entry_in_dir(sb, &clu,
 								      i, NULL);
 			if (!ep)
-				return FFS_MEDIAERR;
+				return -ENOENT;
 
 			type = p_fs->fs_func->get_entry_type((struct dentry_t *)ep);
 
@@ -202,7 +202,7 @@ s32 load_alloc_bitmap(struct super_block *sb)
 		}
 
 		if (FAT_read(sb, clu.dir, &clu.dir) != 0)
-			return FFS_MEDIAERR;
+			return -EIO;
 	}
 
 	return -EFSCORRUPTED;
@@ -391,13 +391,13 @@ static s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 		}
 
 		if (set_alloc_bitmap(sb, new_clu - 2) != FFS_SUCCESS)
-			return -1;
+			return -EIO;
 
 		num_clusters++;
 
 		if (p_chain->flags == 0x01) {
 			if (FAT_write(sb, new_clu, CLUSTER_32(~0)) < 0)
-				return -1;
+				return -EIO;
 		}
 
 		if (p_chain->dir == CLUSTER_32(~0)) {
@@ -405,7 +405,7 @@ static s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 		} else {
 			if (p_chain->flags == 0x01) {
 				if (FAT_write(sb, last_clu, new_clu) < 0)
-					return -1;
+					return -EIO;
 			}
 		}
 		last_clu = new_clu;
@@ -744,14 +744,14 @@ s32 load_upcase_table(struct super_block *sb)
 	clu.flags = 0x01;
 
 	if (p_fs->dev_ejected)
-		return FFS_MEDIAERR;
+		return -EIO;
 
 	while (clu.dir != CLUSTER_32(~0)) {
 		for (i = 0; i < p_fs->dentries_per_clu; i++) {
 			ep = (struct case_dentry_t *)get_entry_in_dir(sb, &clu,
 								      i, NULL);
 			if (!ep)
-				return FFS_MEDIAERR;
+				return -ENOENT;
 
 			type = p_fs->fs_func->get_entry_type((struct dentry_t *)ep);
 
@@ -771,7 +771,7 @@ s32 load_upcase_table(struct super_block *sb)
 			return FFS_SUCCESS;
 		}
 		if (FAT_read(sb, clu.dir, &clu.dir) != 0)
-			return FFS_MEDIAERR;
+			return -EIO;
 	}
 	/* load default upcase table */
 	return __load_default_upcase_table(sb);
@@ -1253,12 +1253,12 @@ static s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 	file_ep = (struct file_dentry_t *)get_entry_in_dir(sb, p_dir, entry,
 							   &sector);
 	if (!file_ep)
-		return FFS_MEDIAERR;
+		return -ENOENT;
 
 	strm_ep = (struct strm_dentry_t *)get_entry_in_dir(sb, p_dir, entry + 1,
 							   &sector);
 	if (!strm_ep)
-		return FFS_MEDIAERR;
+		return -ENOENT;
 
 	init_file_entry(file_ep, type);
 	buf_modify(sb, sector);
@@ -1284,7 +1284,7 @@ static s32 exfat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
 	file_ep = (struct file_dentry_t *)get_entry_in_dir(sb, p_dir, entry,
 							   &sector);
 	if (!file_ep)
-		return FFS_MEDIAERR;
+		return -ENOENT;
 
 	file_ep->num_ext = (u8)(num_entries - 1);
 	buf_modify(sb, sector);
@@ -1292,7 +1292,7 @@ static s32 exfat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
 	strm_ep = (struct strm_dentry_t *)get_entry_in_dir(sb, p_dir, entry + 1,
 							   &sector);
 	if (!strm_ep)
-		return FFS_MEDIAERR;
+		return -ENOENT;
 
 	strm_ep->name_len = p_uniname->name_len;
 	SET16_A(strm_ep->name_hash, p_uniname->name_hash);
@@ -1303,7 +1303,7 @@ static s32 exfat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
 								   entry + i,
 								   &sector);
 		if (!name_ep)
-			return FFS_MEDIAERR;
+			return -ENOENT;
 
 		init_name_entry(name_ep, uniname);
 		buf_modify(sb, sector);
@@ -1348,7 +1348,7 @@ static s32 _walk_fat_chain(struct super_block *sb, struct chain_t *p_dir,
 	} else {
 		while (clu_offset > 0) {
 			if (FAT_read(sb, cur_clu, &cur_clu) == -1)
-				return FFS_MEDIAERR;
+				return -EIO;
 			clu_offset--;
 		}
 	}
@@ -1626,10 +1626,10 @@ static s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_
 		/* (1) allocate a cluster */
 		ret = p_fs->fs_func->alloc_cluster(sb, 1, &clu);
 		if (ret < 1)
-			return -1;
+			return -EIO;
 
 		if (clear_cluster(sb, clu.dir) != FFS_SUCCESS)
-			return -1;
+			return -EIO;
 
 		/* (2) append to the FAT chain */
 		if (clu.flags != p_dir->flags) {
@@ -1639,7 +1639,7 @@ static s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_
 		}
 		if (clu.flags == 0x01)
 			if (FAT_write(sb, last_clu, clu.dir) < 0)
-				return -1;
+				return -EIO;
 
 		if (p_fs->hint_uentry.entry == -1) {
 			p_fs->hint_uentry.dir = p_dir->dir;
@@ -1660,7 +1660,7 @@ static s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_
 				ep = get_entry_in_dir(sb, &fid->dir,
 						      fid->entry + 1, &sector);
 				if (!ep)
-					return -1;
+					return -ENOENT;
 				p_fs->fs_func->set_entry_size(ep, size);
 				p_fs->fs_func->set_entry_flag(ep, p_dir->flags);
 				buf_modify(sb, sector);
@@ -1895,7 +1895,7 @@ s32 count_dos_name_entries(struct super_block *sb, struct chain_t *p_dir,
 		for (i = 0; i < dentries_per_clu; i++) {
 			ep = get_entry_in_dir(sb, &clu, i, NULL);
 			if (!ep)
-				return -1;
+				return -ENOENT;
 
 			entry_type = p_fs->fs_func->get_entry_type(ep);
 
@@ -1919,7 +1919,7 @@ s32 count_dos_name_entries(struct super_block *sb, struct chain_t *p_dir,
 				clu.dir = CLUSTER_32(~0);
 		} else {
 			if (FAT_read(sb, clu.dir, &clu.dir) != 0)
-				return -1;
+				return -EIO;
 		}
 	}
 
@@ -2046,7 +2046,7 @@ static s32 fat_generate_dos_name(struct super_block *sb, struct chain_t *p_dir,
 			ep = (struct dos_dentry_t *)get_entry_in_dir(sb, &clu,
 								     i, NULL);
 			if (!ep)
-				return FFS_MEDIAERR;
+				return -ENOENT;
 
 			type = p_fs->fs_func->get_entry_type((struct dentry_t *)
 							     ep);
@@ -2085,7 +2085,7 @@ static s32 fat_generate_dos_name(struct super_block *sb, struct chain_t *p_dir,
 			break; /* FAT16 root_dir */
 
 		if (FAT_read(sb, clu.dir, &clu.dir) != 0)
-			return FFS_MEDIAERR;
+			return -EIO;
 	}
 
 	count = 0;
@@ -2378,7 +2378,7 @@ s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 	/* (1) allocate a cluster */
 	ret = fs_func->alloc_cluster(sb, 1, &clu);
 	if (ret < 0)
-		return FFS_MEDIAERR;
+		return ret;
 	else if (ret == 0)
 		return -ENOSPC;
 
@@ -2547,7 +2547,7 @@ s32 rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 
 	epold = get_entry_in_dir(sb, p_dir, oldentry, &sector_old);
 	if (!epold)
-		return FFS_MEDIAERR;
+		return -ENOENT;
 
 	buf_lock(sb, sector_old);
 
@@ -2556,7 +2556,7 @@ s32 rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 						     epold);
 	if (num_old_entries < 0) {
 		buf_unlock(sb, sector_old);
-		return FFS_MEDIAERR;
+		return -ENOENT;
 	}
 	num_old_entries++;
 
@@ -2577,7 +2577,7 @@ s32 rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 		epnew = get_entry_in_dir(sb, p_dir, newentry, &sector_new);
 		if (!epnew) {
 			buf_unlock(sb, sector_old);
-			return FFS_MEDIAERR;
+			return -ENOENT;
 		}
 
 		memcpy((void *)epnew, (void *)epold, DENTRY_SIZE);
@@ -2599,7 +2599,7 @@ s32 rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 
 			if (!epold || !epnew) {
 				buf_unlock(sb, sector_old);
-				return FFS_MEDIAERR;
+				return -ENOENT;
 			}
 
 			memcpy((void *)epnew, (void *)epold, DENTRY_SIZE);
@@ -2654,7 +2654,7 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 
 	epmov = get_entry_in_dir(sb, p_olddir, oldentry, &sector_mov);
 	if (!epmov)
-		return FFS_MEDIAERR;
+		return -ENOENT;
 
 	/* check if the source and target directory is the same */
 	if (fs_func->get_entry_type(epmov) == TYPE_DIR &&
@@ -2668,7 +2668,7 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 						     epmov);
 	if (num_old_entries < 0) {
 		buf_unlock(sb, sector_mov);
-		return FFS_MEDIAERR;
+		return -ENOENT;
 	}
 	num_old_entries++;
 
@@ -2688,7 +2688,7 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 	epnew = get_entry_in_dir(sb, p_newdir, newentry, &sector_new);
 	if (!epnew) {
 		buf_unlock(sb, sector_mov);
-		return FFS_MEDIAERR;
+		return -ENOENT;
 	}
 
 	memcpy((void *)epnew, (void *)epmov, DENTRY_SIZE);
@@ -2708,7 +2708,7 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 					 &sector_new);
 		if (!epmov || !epnew) {
 			buf_unlock(sb, sector_mov);
-			return FFS_MEDIAERR;
+			return -ENOENT;
 		}
 
 		memcpy((void *)epnew, (void *)epmov, DENTRY_SIZE);
@@ -2721,7 +2721,7 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 
 		epnew = get_entry_in_dir(sb, &clu, 1, &sector_new);
 		if (!epnew)
-			return FFS_MEDIAERR;
+			return -ENOENT;
 
 		if (p_newdir->dir == p_fs->root_dir)
 			fs_func->set_entry_clu0(epnew, CLUSTER_32(0));
@@ -2753,7 +2753,7 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 int sector_read(struct super_block *sb, sector_t sec, struct buffer_head **bh,
 		bool read)
 {
-	s32 ret = FFS_MEDIAERR;
+	s32 ret = -EIO;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
 	if ((sec >= (p_fs->PBR_sector + p_fs->num_sectors)) &&
@@ -2776,7 +2776,7 @@ int sector_read(struct super_block *sb, sector_t sec, struct buffer_head **bh,
 int sector_write(struct super_block *sb, sector_t sec, struct buffer_head *bh,
 		 bool sync)
 {
-	s32 ret = FFS_MEDIAERR;
+	s32 ret = -EIO;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
 	if (sec >= (p_fs->PBR_sector + p_fs->num_sectors) &&
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 161971c80c02..a5c85dafefb4 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -364,7 +364,9 @@ static int ffsMountVol(struct super_block *sb)
 	bdev_open(sb);
 
 	if (p_bd->sector_size < sb->s_blocksize) {
-		ret = FFS_MEDIAERR;
+		printk(KERN_INFO "EXFAT: maont failed - sector size %d less than blocksize %ld\n",
+			p_bd->sector_size,  sb->s_blocksize);
+		ret = -EINVAL;
 		goto out;
 	}
 	if (p_bd->sector_size > sb->s_blocksize)
@@ -372,7 +374,7 @@ static int ffsMountVol(struct super_block *sb)
 
 	/* read Sector 0 */
 	if (sector_read(sb, 0, &tmp_bh, 1) != FFS_SUCCESS) {
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 		goto out;
 	}
 
@@ -429,7 +431,7 @@ static int ffsMountVol(struct super_block *sb)
 			free_alloc_bitmap(sb);
 		}
 		bdev_close(sb);
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 		goto out;
 	}
 
@@ -469,7 +471,7 @@ static int ffsUmountVol(struct super_block *sb)
 
 	if (p_fs->dev_ejected) {
 		pr_info("[EXFAT] unmounted with media errors. Device is already ejected.\n");
-		err = FFS_MEDIAERR;
+		err = -EIO;
 	}
 
 	buf_shutdown(sb);
@@ -505,7 +507,7 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 	info->FreeClusters = info->NumClusters - info->UsedClusters;
 
 	if (p_fs->dev_ejected)
-		err = FFS_MEDIAERR;
+		err = -EIO;
 
 	/* release the lock for file system critical section */
 	up(&p_fs->v_sem);
@@ -526,7 +528,7 @@ static int ffsSyncVol(struct super_block *sb, bool do_sync)
 	fs_set_vol_flags(sb, VOL_CLEAN);
 
 	if (p_fs->dev_ejected)
-		err = FFS_MEDIAERR;
+		err = -EIO;
 
 	/* release the lock for file system critical section */
 	up(&p_fs->v_sem);
@@ -595,14 +597,14 @@ static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
 			es = get_entry_set_in_dir(sb, &dir, dentry,
 						  ES_2_ENTRIES, &ep);
 			if (!es) {
-				ret =  FFS_MEDIAERR;
+				ret =  -ENOENT;
 				goto out;
 			}
 			ep2 = ep + 1;
 		} else {
 			ep = get_entry_in_dir(sb, &dir, dentry, NULL);
 			if (!ep) {
-				ret =  FFS_MEDIAERR;
+				ret =  -ENOENT;
 				goto out;
 			}
 			ep2 = ep;
@@ -627,7 +629,7 @@ static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
 	}
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 out:
 	/* release the lock for file system critical section */
 	up(&p_fs->v_sem);
@@ -667,7 +669,7 @@ static int ffsCreateFile(struct inode *inode, char *path, u8 mode,
 #endif
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 
 out:
 	/* release the lock for file system critical section */
@@ -738,7 +740,7 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
 			while (clu_offset > 0) {
 				/* clu = FAT_read(sb, clu); */
 				if (FAT_read(sb, clu, &clu) == -1)
-					return FFS_MEDIAERR;
+					return -EIO;
 
 				clu_offset--;
 			}
@@ -791,7 +793,7 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
 		*rcount = read_bytes;
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 
 out:
 	/* release the lock for file system critical section */
@@ -881,7 +883,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 				last_clu = clu;
 				/* clu = FAT_read(sb, clu); */
 				if (FAT_read(sb, clu, &clu) == -1) {
-					ret = FFS_MEDIAERR;
+					ret = -EIO;
 					goto out;
 				}
 				clu_offset--;
@@ -903,7 +905,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 			if (num_alloced == 0)
 				break;
 			if (num_alloced < 0) {
-				ret = FFS_MEDIAERR;
+				ret = num_alloced;
 				goto out;
 			}
 
@@ -1048,7 +1050,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 		ret = -ENOSPC;
 
 	else if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 
 out:
 	/* release the lock for file system critical section */
@@ -1109,7 +1111,7 @@ static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 			while (num_clusters > 0) {
 				last_clu = clu.dir;
 				if (FAT_read(sb, clu.dir, &clu.dir) == -1) {
-					ret = FFS_MEDIAERR;
+					ret = -EIO;
 					goto out;
 				}
 				num_clusters--;
@@ -1131,14 +1133,14 @@ static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 		es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
 					  ES_ALL_ENTRIES, &ep);
 		if (!es) {
-			ret = FFS_MEDIAERR;
+			ret = -ENOENT;
 			goto out;
 			}
 		ep2 = ep + 1;
 	} else {
 		ep = get_entry_in_dir(sb, &(fid->dir), fid->entry, &sector);
 		if (!ep) {
-			ret = FFS_MEDIAERR;
+			ret = -ENOENT;
 			goto out;
 		}
 		ep2 = ep;
@@ -1180,7 +1182,7 @@ static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 #endif
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 
 out:
 	pr_debug("%s exited (%d)\n", __func__, ret);
@@ -1253,7 +1255,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 
 	ep = get_entry_in_dir(sb, &olddir, dentry, NULL);
 	if (!ep) {
-		ret = FFS_MEDIAERR;
+		ret = -ENOENT;
 		goto out2;
 	}
 
@@ -1266,7 +1268,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 	if (new_inode) {
 		u32 entry_type;
 
-		ret = FFS_MEDIAERR;
+		ret = -ENOENT;
 		new_fid = &EXFAT_I(new_inode)->fid;
 
 		update_parent_info(new_fid, new_parent_inode);
@@ -1328,7 +1330,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 #endif
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 out2:
 	/* release the lock for file system critical section */
 	up(&p_fs->v_sem);
@@ -1360,7 +1362,7 @@ static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
 
 	ep = get_entry_in_dir(sb, &dir, dentry, NULL);
 	if (!ep) {
-		ret = FFS_MEDIAERR;
+		ret = -ENOENT;
 		goto out;
 	}
 
@@ -1390,7 +1392,7 @@ static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
 #endif
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 out:
 	/* release the lock for file system critical section */
 	up(&p_fs->v_sem);
@@ -1414,7 +1416,7 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 
 	if (fid->attr == attr) {
 		if (p_fs->dev_ejected)
-			return FFS_MEDIAERR;
+			return -EIO;
 		return FFS_SUCCESS;
 	}
 
@@ -1422,7 +1424,7 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 		if ((fid->dir.dir == p_fs->root_dir) &&
 		    (fid->entry == -1)) {
 			if (p_fs->dev_ejected)
-				return FFS_MEDIAERR;
+				return -EIO;
 			return FFS_SUCCESS;
 		}
 	}
@@ -1435,13 +1437,13 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 		es = get_entry_set_in_dir(sb, &(fid->dir), fid->entry,
 					  ES_ALL_ENTRIES, &ep);
 		if (!es) {
-			ret = FFS_MEDIAERR;
+			ret = -ENOENT;
 			goto out;
 		}
 	} else {
 		ep = get_entry_in_dir(sb, &(fid->dir), fid->entry, &sector);
 		if (!ep) {
-			ret = FFS_MEDIAERR;
+			ret = -ENOENT;
 			goto out;
 		}
 	}
@@ -1451,7 +1453,7 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 	if (((type == TYPE_FILE) && (attr & ATTR_SUBDIR)) ||
 	    ((type == TYPE_DIR) && (!(attr & ATTR_SUBDIR)))) {
 		if (p_fs->dev_ejected)
-			ret = FFS_MEDIAERR;
+			ret = -EIO;
 		else
 			ret = FFS_ERROR;
 
@@ -1479,7 +1481,7 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 #endif
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 out:
 	/* release the lock for file system critical section */
 	up(&p_fs->v_sem);
@@ -1535,13 +1537,13 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 
 			count = count_dos_name_entries(sb, &dir, TYPE_DIR);
 			if (count < 0) {
-				ret = FFS_MEDIAERR;
+				ret = count; /* propogate error upward */
 				goto out;
 			}
 			info->NumSubdirs = count;
 
 			if (p_fs->dev_ejected)
-				ret = FFS_MEDIAERR;
+				ret = -EIO;
 			goto out;
 		}
 	}
@@ -1551,14 +1553,14 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 		es = get_entry_set_in_dir(sb, &(fid->dir), fid->entry,
 					  ES_2_ENTRIES, &ep);
 		if (!es) {
-			ret = FFS_MEDIAERR;
+			ret = -ENOENT;
 			goto out;
 		}
 		ep2 = ep + 1;
 	} else {
 		ep = get_entry_in_dir(sb, &(fid->dir), fid->entry, &sector);
 		if (!ep) {
-			ret = FFS_MEDIAERR;
+			ret = -ENOENT;
 			goto out;
 		}
 		ep2 = ep;
@@ -1624,14 +1626,14 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 
 		count = count_dos_name_entries(sb, &dir, TYPE_DIR);
 		if (count < 0) {
-			ret = FFS_MEDIAERR;
+			ret = count; /* propogate error upward */
 			goto out;
 		}
 		info->NumSubdirs += count;
 	}
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 
 out:
 	/* release the lock for file system critical section */
@@ -1662,7 +1664,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 		if ((fid->dir.dir == p_fs->root_dir) &&
 		    (fid->entry == -1)) {
 			if (p_fs->dev_ejected)
-				ret = FFS_MEDIAERR;
+				ret = -EIO;
 			ret = FFS_SUCCESS;
 			goto out;
 		}
@@ -1675,7 +1677,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 		es = get_entry_set_in_dir(sb, &(fid->dir), fid->entry,
 					  ES_ALL_ENTRIES, &ep);
 		if (!es) {
-			ret = FFS_MEDIAERR;
+			ret = -ENOENT;
 			goto out;
 		}
 		ep2 = ep + 1;
@@ -1683,7 +1685,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 		/* for other than exfat */
 		ep = get_entry_in_dir(sb, &(fid->dir), fid->entry, &sector);
 		if (!ep) {
-			ret = FFS_MEDIAERR;
+			ret = -ENOENT;
 			goto out;
 		}
 		ep2 = ep;
@@ -1718,7 +1720,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	}
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 
 out:
 	/* release the lock for file system critical section */
@@ -1780,7 +1782,7 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 		while ((clu_offset > 0) && (*clu != CLUSTER_32(~0))) {
 			last_clu = *clu;
 			if (FAT_read(sb, *clu, clu) == -1) {
-				ret = FFS_MEDIAERR;
+				ret = -EIO;
 				goto out;
 			}
 			clu_offset--;
@@ -1798,7 +1800,7 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 		/* (1) allocate a cluster */
 		num_alloced = p_fs->fs_func->alloc_cluster(sb, 1, &new_clu);
 		if (num_alloced < 0) {
-			ret = FFS_MEDIAERR;
+			ret = -EIO;
 			goto out;
 		} else if (num_alloced == 0) {
 			ret = -ENOSPC;
@@ -1829,7 +1831,7 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 			es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
 						  ES_ALL_ENTRIES, &ep);
 			if (!es) {
-				ret = FFS_MEDIAERR;
+				ret = -ENOENT;
 				goto out;
 			}
 			/* get stream entry */
@@ -1842,7 +1844,7 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 				ep = get_entry_in_dir(sb, &(fid->dir),
 						      fid->entry, &sector);
 				if (!ep) {
-					ret = FFS_MEDIAERR;
+					ret = -ENOENT;
 					goto out;
 				}
 			}
@@ -1872,7 +1874,7 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 	fid->hint_last_clu = *clu;
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 
 out:
 	/* release the lock for file system critical section */
@@ -1917,7 +1919,7 @@ static int ffsCreateDir(struct inode *inode, char *path, struct file_id_t *fid)
 #endif
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 out:
 	/* release the lock for file system critical section */
 	up(&p_fs->v_sem);
@@ -1947,7 +1949,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 
 	/* check if the given file ID is opened */
 	if (fid->type != TYPE_DIR)
-		return -EPERM;
+		return -ENOTDIR;
 
 	/* acquire the lock for file system critical section */
 	down(&p_fs->v_sem);
@@ -1997,7 +1999,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			while (clu_offset > 0) {
 				/* clu.dir = FAT_read(sb, clu.dir); */
 				if (FAT_read(sb, clu.dir, &clu.dir) == -1) {
-					ret = FFS_MEDIAERR;
+					ret = -EIO;
 					goto out;
 				}
 				clu_offset--;
@@ -2017,7 +2019,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 		for ( ; i < dentries_per_clu; i++, dentry++) {
 			ep = get_entry_in_dir(sb, &clu, i, &sector);
 			if (!ep) {
-				ret = FFS_MEDIAERR;
+				ret = -ENOENT;
 				goto out;
 			}
 			type = fs_func->get_entry_type(ep);
@@ -2065,7 +2067,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			if (p_fs->vol_type == EXFAT) {
 				ep = get_entry_in_dir(sb, &clu, i + 1, NULL);
 				if (!ep) {
-					ret = FFS_MEDIAERR;
+					ret = -ENOENT;
 					goto out;
 				}
 			} else {
@@ -2089,7 +2091,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			fid->rwoffset = (s64)(++dentry);
 
 			if (p_fs->dev_ejected)
-				ret = FFS_MEDIAERR;
+				ret = -EIO;
 			goto out;
 		}
 
@@ -2104,7 +2106,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 		} else {
 			/* clu.dir = FAT_read(sb, clu.dir); */
 			if (FAT_read(sb, clu.dir, &clu.dir) == -1) {
-				ret = FFS_MEDIAERR;
+				ret = -EIO;
 				goto out;
 			}
 		}
@@ -2115,7 +2117,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 	fid->rwoffset = (s64)(++dentry);
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 
 out:
 	/* release the lock for file system critical section */
@@ -2178,7 +2180,7 @@ static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
 #endif
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 
 out:
 	/* release the lock for file system critical section */
@@ -2238,12 +2240,11 @@ static int exfat_readdir(struct file *filp, struct dir_context *ctx)
 		/* at least we tried to read a sector
 		 * move cpos to next sector position (should be aligned)
 		 */
-		if (err == FFS_MEDIAERR) {
+		if (err == -EIO) {
 			cpos += 1 << p_bd->sector_size_bits;
 			cpos &= ~((1 << p_bd->sector_size_bits) - 1);
 		}
 
-		err = -EIO;
 		goto end_of_dir;
 	}
 
@@ -3495,7 +3496,7 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct vol_info_t info;
 
 	if (p_fs->used_clusters == UINT_MAX) {
-		if (ffsGetVolInfo(sb, &info) == FFS_MEDIAERR)
+		if (ffsGetVolInfo(sb, &info) == -EIO)
 			return -EIO;
 
 	} else {
-- 
2.23.0

