Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45161F86B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 03:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfKLCKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 21:10:54 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:45734 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727201AbfKLCKx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:10:53 -0500
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xAC2AqHv028429
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 21:10:52 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xAC2AkV6000457
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 21:10:52 -0500
Received: by mail-qt1-f197.google.com with SMTP id x50so19176247qth.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 18:10:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Nnu0KYEj/V8ujnYEOSoBrL0wk0HA8d3kg1Y8V4xe3kQ=;
        b=qIolgMaEXlR/W7d+6FVMlUfZ/5ldlMulUKvV+VHFLWpf3YqV5Y795StRvCYo4mYfZq
         xCHyyxiqaPnmDHT5pd/0h+GEjQOOkk0Qz8QPQlJqMbOsnEH3F4JzHo+ZLIwO0XByRgRU
         UFAurS0N0hmtBhbvN6ARdsQgbrqUbp0CGJXpMm3tWVmHQnJkUfdiBLBiQRV/TbjNr40F
         uFf/BxUPwo7LN6RICf4oH2a5gISROS1bCdLLD/7yq4uNZl8+2ubIbcCv4QLelX4I9+o6
         cR53gdwBSIJrOQ/xrlGSBe/CTt6sSMHxtSSuBRX4yVCkbzL0CsgT3nWNzmfdMAYI/1bf
         jiiA==
X-Gm-Message-State: APjAAAWrrEkDvC7VviG2PXvGZR9pHpzg4SMgMNYlrmMrMpjahNPTwvxV
        8Yh3Su5aOAxBS4Zzg7I2zLO4NpI1Qp9h+6Df9/AMs5xBqw4CL0YrKis3woOPH0bdwxrDglOGMSl
        NUXyLM7qsBCvw2q1snNYxkao6lY/dD5mtrjsq
X-Received: by 2002:aed:2907:: with SMTP id s7mr29256540qtd.265.1573524646634;
        Mon, 11 Nov 2019 18:10:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqzN1E+pJZH9X/hfwcocGv5SXAuZjUWZDj1qbkRSluT6qUYqtVIJa91NniS90nHz5UnGFIPjpg==
X-Received: by 2002:aed:2907:: with SMTP id s7mr29256512qtd.265.1573524645936;
        Mon, 11 Nov 2019 18:10:45 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id o195sm8004767qke.35.2019.11.11.18.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 18:10:45 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     gregkh@linuxfoundation.org
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/9] staging: exfat: Clean up return codes - FFS_SUCCESS
Date:   Mon, 11 Nov 2019 21:09:55 -0500
Message-Id: <20191112021000.42091-8-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
References: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert FFS_SUCCESS to 0.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       |   3 -
 drivers/staging/exfat/exfat_cache.c |   4 +-
 drivers/staging/exfat/exfat_core.c  | 104 ++++++++++++++--------------
 drivers/staging/exfat/exfat_super.c |  50 ++++++-------
 4 files changed, 79 insertions(+), 82 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index b3fc9bb06c24..72cf40e123de 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -208,9 +208,6 @@ static inline u16 get_row_index(u16 i)
 #define FM_REGULAR              0x00
 #define FM_SYMLINK              0x40
 
-/* return values */
-#define FFS_SUCCESS             0
-
 #define NUM_UPCASE              2918
 
 #define DOS_CUR_DIR_NAME        ".          "
diff --git a/drivers/staging/exfat/exfat_cache.c b/drivers/staging/exfat/exfat_cache.c
index 467b93630d86..28a67f8139ea 100644
--- a/drivers/staging/exfat/exfat_cache.c
+++ b/drivers/staging/exfat/exfat_cache.c
@@ -462,7 +462,7 @@ u8 *FAT_getblk(struct super_block *sb, sector_t sec)
 
 	FAT_cache_insert_hash(sb, bp);
 
-	if (sector_read(sb, sec, &bp->buf_bh, 1) != FFS_SUCCESS) {
+	if (sector_read(sb, sec, &bp->buf_bh, 1) != 0) {
 		FAT_cache_remove_hash(bp);
 		bp->drv = -1;
 		bp->sec = ~0;
@@ -582,7 +582,7 @@ static u8 *__buf_getblk(struct super_block *sb, sector_t sec)
 
 	buf_cache_insert_hash(sb, bp);
 
-	if (sector_read(sb, sec, &bp->buf_bh, 1) != FFS_SUCCESS) {
+	if (sector_read(sb, sec, &bp->buf_bh, 1) != 0) {
 		buf_cache_remove_hash(bp);
 		bp->drv = -1;
 		bp->sec = ~0;
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index ffcad6867ecb..1f0ef94bdd47 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -102,7 +102,7 @@ void fs_set_vol_flags(struct super_block *sb, u32 new_flag)
 	if (p_fs->vol_type == EXFAT) {
 		if (!p_fs->pbr_bh) {
 			if (sector_read(sb, p_fs->PBR_sector,
-					&p_fs->pbr_bh, 1) != FFS_SUCCESS)
+					&p_fs->pbr_bh, 1) != 0)
 				return;
 		}
 
@@ -139,7 +139,7 @@ void fs_error(struct super_block *sb)
 s32 clear_cluster(struct super_block *sb, u32 clu)
 {
 	sector_t s, n;
-	s32 ret = FFS_SUCCESS;
+	s32 ret = 0;
 	struct buffer_head *tmp_bh = NULL;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
@@ -154,12 +154,12 @@ s32 clear_cluster(struct super_block *sb, u32 clu)
 
 	for (; s < n; s++) {
 		ret = sector_read(sb, s, &tmp_bh, 0);
-		if (ret != FFS_SUCCESS)
+		if (ret != 0)
 			return ret;
 
 		memset((char *)tmp_bh->b_data, 0x0, p_bd->sector_size);
 		ret = sector_write(sb, s, tmp_bh, 0);
-		if (ret != FFS_SUCCESS)
+		if (ret != 0)
 			break;
 	}
 
@@ -251,7 +251,7 @@ s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 			}
 		}
 
-		if (set_alloc_bitmap(sb, new_clu - 2) != FFS_SUCCESS)
+		if (set_alloc_bitmap(sb, new_clu - 2) != 0)
 			return -EIO;
 
 		num_clusters++;
@@ -370,7 +370,7 @@ void exfat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
 					buf_release(sb, sector + i);
 			}
 
-			if (clr_alloc_bitmap(sb, clu - 2) != FFS_SUCCESS)
+			if (clr_alloc_bitmap(sb, clu - 2) != 0)
 				break;
 			clu++;
 
@@ -387,7 +387,7 @@ void exfat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
 					buf_release(sb, sector + i);
 			}
 
-			if (clr_alloc_bitmap(sb, clu - 2) != FFS_SUCCESS)
+			if (clr_alloc_bitmap(sb, clu - 2) != 0)
 				break;
 
 			if (FAT_read(sb, clu, &clu) == -1)
@@ -552,7 +552,7 @@ s32 load_alloc_bitmap(struct super_block *sb)
 				for (j = 0; j < p_fs->map_sectors; j++) {
 					p_fs->vol_amap[j] = NULL;
 					ret = sector_read(sb, sector + j, &p_fs->vol_amap[j], 1);
-					if (ret != FFS_SUCCESS) {
+					if (ret != 0) {
 						/*  release all buffers and free vol_amap */
 						i = 0;
 						while (i < j)
@@ -565,7 +565,7 @@ s32 load_alloc_bitmap(struct super_block *sb)
 				}
 
 				p_fs->pbr_bh = NULL;
-				return FFS_SUCCESS;
+				return 0;
 			}
 		}
 
@@ -721,7 +721,7 @@ static s32 __load_upcase_table(struct super_block *sb, sector_t sector,
 
 	while (sector < end_sector) {
 		ret = sector_read(sb, sector, &tmp_bh, 1);
-		if (ret != FFS_SUCCESS) {
+		if (ret != 0) {
 			pr_debug("sector read (0x%llX)fail\n",
 				 (unsigned long long)sector);
 			goto error;
@@ -772,7 +772,7 @@ static s32 __load_upcase_table(struct super_block *sb, sector_t sector,
 	if (index >= 0xFFFF && utbl_checksum == checksum) {
 		if (tmp_bh)
 			brelse(tmp_bh);
-		return FFS_SUCCESS;
+		return 0;
 	}
 	ret = -EINVAL;
 error:
@@ -833,7 +833,7 @@ static s32 __load_default_upcase_table(struct super_block *sb)
 	}
 
 	if (index >= 0xFFFF)
-		return FFS_SUCCESS;
+		return 0;
 
 error:
 	/* FATAL error: default upcase table has error */
@@ -878,9 +878,9 @@ s32 load_upcase_table(struct super_block *sb)
 			sector = START_SECTOR(tbl_clu);
 			num_sectors = ((tbl_size - 1) >> p_bd->sector_size_bits) + 1;
 			if (__load_upcase_table(sb, sector, num_sectors,
-						GET32_A(ep->checksum)) != FFS_SUCCESS)
+						GET32_A(ep->checksum)) != 0)
 				break;
-			return FFS_SUCCESS;
+			return 0;
 		}
 		if (FAT_read(sb, clu.dir, &clu.dir) != 0)
 			return -EIO;
@@ -1251,7 +1251,7 @@ s32 fat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir, s32 entry,
 	init_dos_entry(dos_ep, type, start_clu);
 	buf_modify(sb, sector);
 
-	return FFS_SUCCESS;
+	return 0;
 }
 
 s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
@@ -1281,7 +1281,7 @@ s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 	init_strm_entry(strm_ep, flags, start_clu, size);
 	buf_modify(sb, sector);
 
-	return FFS_SUCCESS;
+	return 0;
 }
 
 static s32 fat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
@@ -1332,7 +1332,7 @@ static s32 fat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
 		buf_modify(sb, sector);
 	}
 
-	return FFS_SUCCESS;
+	return 0;
 }
 
 static s32 exfat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
@@ -1378,7 +1378,7 @@ static s32 exfat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
 
 	update_dir_checksum(sb, p_dir, entry);
 
-	return FFS_SUCCESS;
+	return 0;
 }
 
 void init_dos_entry(struct dos_dentry_t *ep, u32 type, u32 start_clu)
@@ -1599,7 +1599,7 @@ static s32 _walk_fat_chain(struct super_block *sb, struct chain_t *p_dir,
 
 	if (clu)
 		*clu = cur_clu;
-	return FFS_SUCCESS;
+	return 0;
 }
 
 s32 find_location(struct super_block *sb, struct chain_t *p_dir, s32 entry,
@@ -1618,7 +1618,7 @@ s32 find_location(struct super_block *sb, struct chain_t *p_dir, s32 entry,
 		*sector += p_fs->root_start_sector;
 	} else {
 		ret = _walk_fat_chain(sb, p_dir, off, &clu);
-		if (ret != FFS_SUCCESS)
+		if (ret != 0)
 			return ret;
 
 		/* byte offset in cluster */
@@ -1631,7 +1631,7 @@ s32 find_location(struct super_block *sb, struct chain_t *p_dir, s32 entry,
 		*sector = off >> p_bd->sector_size_bits;
 		*sector += START_SECTOR(clu);
 	}
-	return FFS_SUCCESS;
+	return 0;
 }
 
 struct dentry_t *get_entry_with_sector(struct super_block *sb, sector_t sector,
@@ -1654,7 +1654,7 @@ struct dentry_t *get_entry_in_dir(struct super_block *sb, struct chain_t *p_dir,
 	sector_t sec;
 	u8 *buf;
 
-	if (find_location(sb, p_dir, entry, &sec, &off) != FFS_SUCCESS)
+	if (find_location(sb, p_dir, entry, &sec, &off) != 0)
 		return NULL;
 
 	buf = buf_getblk(sb, sec);
@@ -1708,7 +1708,7 @@ struct entry_set_cache_t *get_entry_set_in_dir(struct super_block *sb,
 
 	byte_offset = entry << DENTRY_SIZE_BITS;
 	ret = _walk_fat_chain(sb, p_dir, byte_offset, &clu);
-	if (ret != FFS_SUCCESS)
+	if (ret != 0)
 		return NULL;
 
 	/* byte offset in cluster */
@@ -1903,7 +1903,7 @@ static s32 __write_partial_entries_in_entry_set(struct super_block *sb,
 	}
 
 	pr_debug("%s exited successfully\n", __func__);
-	return FFS_SUCCESS;
+	return 0;
 err_out:
 	pr_debug("%s failed\n", __func__);
 	return -EINVAL;
@@ -1942,7 +1942,7 @@ s32 write_partial_entries_in_entry_set(struct super_block *sb,
 	byte_offset += ((void **)ep - &es->__buf) + es->offset;
 
 	ret = _walk_fat_chain(sb, &dir, byte_offset, &clu);
-	if (ret != FFS_SUCCESS)
+	if (ret != 0)
 		return ret;
 
 	/* byte offset in cluster */
@@ -2086,7 +2086,7 @@ s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_entries
 		if (ret < 1)
 			return -EIO;
 
-		if (clear_cluster(sb, clu.dir) != FFS_SUCCESS)
+		if (clear_cluster(sb, clu.dir) != 0)
 			return -EIO;
 
 		/* (2) append to the FAT chain */
@@ -2597,7 +2597,7 @@ s32 get_num_entries_and_dos_name(struct super_block *sb, struct chain_t *p_dir,
 
 	*entries = num_entries;
 
-	return FFS_SUCCESS;
+	return 0;
 }
 
 void get_uni_name_from_dos_entry(struct super_block *sb,
@@ -2833,7 +2833,7 @@ s32 fat_generate_dos_name(struct super_block *sb, struct chain_t *p_dir,
 	fat_attach_count_to_dos_name(p_dosname->name, count);
 
 	/* Now dos_name has DOS~????.EXT */
-	return FFS_SUCCESS;
+	return 0;
 }
 
 void fat_attach_count_to_dos_name(u8 *dosname, s32 count)
@@ -2975,7 +2975,7 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
 	p_dir->size = (s32)(fid->size >> p_fs->cluster_size_bits);
 	p_dir->flags = fid->flags;
 
-	return FFS_SUCCESS;
+	return 0;
 }
 
 /*
@@ -3067,7 +3067,7 @@ s32 fat16_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
 
 	p_fs->fs_func = &fat_fs_func;
 
-	return FFS_SUCCESS;
+	return 0;
 }
 
 s32 fat32_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
@@ -3120,7 +3120,7 @@ s32 fat32_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
 
 	p_fs->fs_func = &fat_fs_func;
 
-	return FFS_SUCCESS;
+	return 0;
 }
 
 static struct fs_func exfat_fs_func = {
@@ -3195,7 +3195,7 @@ s32 exfat_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
 
 	p_fs->fs_func = &exfat_fs_func;
 
-	return FFS_SUCCESS;
+	return 0;
 }
 
 s32 create_dir(struct inode *inode, struct chain_t *p_dir,
@@ -3231,7 +3231,7 @@ s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 		return -ENOSPC;
 
 	ret = clear_cluster(sb, clu.dir);
-	if (ret != FFS_SUCCESS)
+	if (ret != 0)
 		return ret;
 
 	if (p_fs->vol_type == EXFAT) {
@@ -3249,11 +3249,11 @@ s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 
 		ret = fs_func->init_dir_entry(sb, &clu, 0, TYPE_DIR, clu.dir,
 					      0);
-		if (ret != FFS_SUCCESS)
+		if (ret != 0)
 			return ret;
 
 		ret = fs_func->init_ext_entry(sb, &clu, 0, 1, NULL, &dot_name);
-		if (ret != FFS_SUCCESS)
+		if (ret != 0)
 			return ret;
 
 		memcpy(dot_name.name, DOS_PAR_DIR_NAME, DOS_NAME_LENGTH);
@@ -3265,12 +3265,12 @@ s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 			ret = fs_func->init_dir_entry(sb, &clu, 1, TYPE_DIR,
 						      p_dir->dir, 0);
 
-		if (ret != FFS_SUCCESS)
+		if (ret != 0)
 			return ret;
 
 		ret = p_fs->fs_func->init_ext_entry(sb, &clu, 1, 1, NULL,
 						    &dot_name);
-		if (ret != FFS_SUCCESS)
+		if (ret != 0)
 			return ret;
 	}
 
@@ -3278,12 +3278,12 @@ s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 	/* make sub-dir entry in parent directory */
 	ret = fs_func->init_dir_entry(sb, p_dir, dentry, TYPE_DIR, clu.dir,
 				      size);
-	if (ret != FFS_SUCCESS)
+	if (ret != 0)
 		return ret;
 
 	ret = fs_func->init_ext_entry(sb, p_dir, dentry, num_entries, p_uniname,
 				      &dos_name);
-	if (ret != FFS_SUCCESS)
+	if (ret != 0)
 		return ret;
 
 	fid->dir.dir = p_dir->dir;
@@ -3300,7 +3300,7 @@ s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 	fid->rwoffset = 0;
 	fid->hint_last_off = -1;
 
-	return FFS_SUCCESS;
+	return 0;
 }
 
 s32 create_file(struct inode *inode, struct chain_t *p_dir,
@@ -3328,12 +3328,12 @@ s32 create_file(struct inode *inode, struct chain_t *p_dir,
 	 */
 	ret = fs_func->init_dir_entry(sb, p_dir, dentry, TYPE_FILE | mode,
 				      CLUSTER_32(0), 0);
-	if (ret != FFS_SUCCESS)
+	if (ret != 0)
 		return ret;
 
 	ret = fs_func->init_ext_entry(sb, p_dir, dentry, num_entries, p_uniname,
 				      &dos_name);
-	if (ret != FFS_SUCCESS)
+	if (ret != 0)
 		return ret;
 
 	fid->dir.dir = p_dir->dir;
@@ -3350,7 +3350,7 @@ s32 create_file(struct inode *inode, struct chain_t *p_dir,
 	fid->rwoffset = 0;
 	fid->hint_last_off = -1;
 
-	return FFS_SUCCESS;
+	return 0;
 }
 
 void remove_file(struct inode *inode, struct chain_t *p_dir, s32 entry)
@@ -3458,7 +3458,7 @@ s32 rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 		ret = fs_func->init_ext_entry(sb, p_dir, newentry,
 					      num_new_entries, p_uniname,
 					      &dos_name);
-		if (ret != FFS_SUCCESS)
+		if (ret != 0)
 			return ret;
 
 		fs_func->delete_dir_entry(sb, p_dir, oldentry, 0,
@@ -3477,14 +3477,14 @@ s32 rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 		ret = fs_func->init_ext_entry(sb, p_dir, oldentry,
 					      num_new_entries, p_uniname,
 					      &dos_name);
-		if (ret != FFS_SUCCESS)
+		if (ret != 0)
 			return ret;
 
 		fs_func->delete_dir_entry(sb, p_dir, oldentry, num_new_entries,
 					  num_old_entries);
 	}
 
-	return FFS_SUCCESS;
+	return 0;
 }
 
 s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
@@ -3580,7 +3580,7 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 
 	ret = fs_func->init_ext_entry(sb, p_newdir, newentry, num_new_entries,
 				      p_uniname, &dos_name);
-	if (ret != FFS_SUCCESS)
+	if (ret != 0)
 		return ret;
 
 	fs_func->delete_dir_entry(sb, p_olddir, oldentry, 0, num_old_entries);
@@ -3591,7 +3591,7 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 
 	fid->entry = newentry;
 
-	return FFS_SUCCESS;
+	return 0;
 }
 
 /*
@@ -3614,7 +3614,7 @@ int sector_read(struct super_block *sb, sector_t sec, struct buffer_head **bh,
 
 	if (!p_fs->dev_ejected) {
 		ret = bdev_read(sb, sec, bh, 1, read);
-		if (ret != FFS_SUCCESS)
+		if (ret != 0)
 			p_fs->dev_ejected = 1;
 	}
 
@@ -3643,7 +3643,7 @@ int sector_write(struct super_block *sb, sector_t sec, struct buffer_head *bh,
 
 	if (!p_fs->dev_ejected) {
 		ret = bdev_write(sb, sec, bh, 1, sync);
-		if (ret != FFS_SUCCESS)
+		if (ret != 0)
 			p_fs->dev_ejected = 1;
 	}
 
@@ -3666,7 +3666,7 @@ int multi_sector_read(struct super_block *sb, sector_t sec,
 
 	if (!p_fs->dev_ejected) {
 		ret = bdev_read(sb, sec, bh, num_secs, read);
-		if (ret != FFS_SUCCESS)
+		if (ret != 0)
 			p_fs->dev_ejected = 1;
 	}
 
@@ -3694,7 +3694,7 @@ int multi_sector_write(struct super_block *sb, sector_t sec,
 
 	if (!p_fs->dev_ejected) {
 		ret = bdev_write(sb, sec, bh, num_secs, sync);
-		if (ret != FFS_SUCCESS)
+		if (ret != 0)
 			p_fs->dev_ejected = 1;
 	}
 
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index daded767182a..5d538593b5f6 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -373,7 +373,7 @@ static int ffsMountVol(struct super_block *sb)
 		sb_set_blocksize(sb, p_bd->sector_size);
 
 	/* read Sector 0 */
-	if (sector_read(sb, 0, &tmp_bh, 1) != FFS_SUCCESS) {
+	if (sector_read(sb, 0, &tmp_bh, 1) != 0) {
 		ret = -EIO;
 		goto out;
 	}
@@ -452,7 +452,7 @@ static int ffsMountVol(struct super_block *sb)
 static int ffsUmountVol(struct super_block *sb)
 {
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	int err = FFS_SUCCESS;
+	int err = 0;
 
 	pr_info("[EXFAT] trying to unmount...\n");
 
@@ -493,7 +493,7 @@ static int ffsUmountVol(struct super_block *sb)
 
 static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 {
-	int err = FFS_SUCCESS;
+	int err = 0;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
 	/* check the validity of pointer parameters */
@@ -523,7 +523,7 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 
 static int ffsSyncVol(struct super_block *sb, bool do_sync)
 {
-	int err = FFS_SUCCESS;
+	int err = 0;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
 	/* acquire the lock for file system critical section */
@@ -776,13 +776,13 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
 
 		if ((offset == 0) && (oneblkread == p_bd->sector_size)) {
 			if (sector_read(sb, LogSector, &tmp_bh, 1) !=
-			    FFS_SUCCESS)
+			    0)
 				goto err_out;
 			memcpy((char *)buffer + read_bytes,
 			       (char *)tmp_bh->b_data, (s32)oneblkread);
 		} else {
 			if (sector_read(sb, LogSector, &tmp_bh, 1) !=
-			    FFS_SUCCESS)
+			    0)
 				goto err_out;
 			memcpy((char *)buffer + read_bytes,
 			       (char *)tmp_bh->b_data + offset,
@@ -852,7 +852,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 	if (count == 0) {
 		if (wcount)
 			*wcount = 0;
-		ret = FFS_SUCCESS;
+		ret = 0;
 		goto out;
 	}
 
@@ -962,12 +962,12 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 
 		if ((offset == 0) && (oneblkwrite == p_bd->sector_size)) {
 			if (sector_read(sb, LogSector, &tmp_bh, 0) !=
-			    FFS_SUCCESS)
+			    0)
 				goto err_out;
 			memcpy((char *)tmp_bh->b_data,
 			       (char *)buffer + write_bytes, (s32)oneblkwrite);
 			if (sector_write(sb, LogSector, tmp_bh, 0) !=
-			    FFS_SUCCESS) {
+			    0) {
 				brelse(tmp_bh);
 				goto err_out;
 			}
@@ -975,18 +975,18 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 			if ((offset > 0) ||
 			    ((fid->rwoffset + oneblkwrite) < fid->size)) {
 				if (sector_read(sb, LogSector, &tmp_bh, 1) !=
-				    FFS_SUCCESS)
+				    0)
 					goto err_out;
 			} else {
 				if (sector_read(sb, LogSector, &tmp_bh, 0) !=
-				    FFS_SUCCESS)
+				    0)
 					goto err_out;
 			}
 
 			memcpy((char *)tmp_bh->b_data + offset,
 			       (char *)buffer + write_bytes, (s32)oneblkwrite);
 			if (sector_write(sb, LogSector, tmp_bh, 0) !=
-			    FFS_SUCCESS) {
+			    0) {
 				brelse(tmp_bh);
 				goto err_out;
 			}
@@ -1100,7 +1100,7 @@ static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 	}
 
 	if (old_size <= new_size) {
-		ret = FFS_SUCCESS;
+		ret = 0;
 		goto out;
 	}
 
@@ -1319,7 +1319,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 		ret = move_file(new_parent_inode, &olddir, dentry, &newdir,
 				&uni_name, fid);
 
-	if ((ret == FFS_SUCCESS) && new_inode) {
+	if ((ret == 0) && new_inode) {
 		/* delete entries of new_dir */
 		ep = get_entry_in_dir(sb, p_dir, new_entry, NULL);
 		if (!ep)
@@ -1350,7 +1350,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
 {
 	s32 dentry;
-	int ret = FFS_SUCCESS;
+	int ret = 0;
 	struct chain_t dir, clu_to_free;
 	struct dentry_t *ep;
 	struct super_block *sb = inode->i_sb;
@@ -1414,7 +1414,7 @@ static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
 static int ffsSetAttr(struct inode *inode, u32 attr)
 {
 	u32 type;
-	int ret = FFS_SUCCESS;
+	int ret = 0;
 	sector_t sector = 0;
 	struct dentry_t *ep;
 	struct super_block *sb = inode->i_sb;
@@ -1426,7 +1426,7 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 	if (fid->attr == attr) {
 		if (p_fs->dev_ejected)
 			return -EIO;
-		return FFS_SUCCESS;
+		return 0;
 	}
 
 	if (is_dir) {
@@ -1434,7 +1434,7 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 		    (fid->entry == -1)) {
 			if (p_fs->dev_ejected)
 				return -EIO;
-			return FFS_SUCCESS;
+			return 0;
 		}
 	}
 
@@ -1503,7 +1503,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 {
 	sector_t sector = 0;
 	s32 count;
-	int ret = FFS_SUCCESS;
+	int ret = 0;
 	struct chain_t dir;
 	struct uni_name_t uni_name;
 	struct timestamp_t tm;
@@ -1655,7 +1655,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 {
 	sector_t sector = 0;
-	int ret = FFS_SUCCESS;
+	int ret = 0;
 	struct timestamp_t tm;
 	struct dentry_t *ep, *ep2;
 	struct entry_set_cache_t *es = NULL;
@@ -1674,7 +1674,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 		    (fid->entry == -1)) {
 			if (p_fs->dev_ejected)
 				ret = -EIO;
-			ret = FFS_SUCCESS;
+			ret = 0;
 			goto out;
 		}
 	}
@@ -1745,7 +1745,7 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 	s32 num_clusters, num_alloced;
 	bool modified = false;
 	u32 last_clu;
-	int ret = FFS_SUCCESS;
+	int ret = 0;
 	sector_t sector = 0;
 	struct chain_t new_clu;
 	struct dentry_t *ep;
@@ -1898,7 +1898,7 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 
 static int ffsCreateDir(struct inode *inode, char *path, struct file_id_t *fid)
 {
-	int ret = FFS_SUCCESS;
+	int ret = 0;
 	struct chain_t dir;
 	struct uni_name_t uni_name;
 	struct super_block *sb = inode->i_sb;
@@ -1939,7 +1939,7 @@ static int ffsCreateDir(struct inode *inode, char *path, struct file_id_t *fid)
 static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 {
 	int i, dentry, clu_offset;
-	int ret = FFS_SUCCESS;
+	int ret = 0;
 	s32 dentries_per_clu, dentries_per_clu_bits = 0;
 	u32 type;
 	sector_t sector;
@@ -2138,7 +2138,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
 {
 	s32 dentry;
-	int ret = FFS_SUCCESS;
+	int ret = 0;
 	struct chain_t dir, clu_to_free;
 	struct super_block *sb = inode->i_sb;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-- 
2.24.0

