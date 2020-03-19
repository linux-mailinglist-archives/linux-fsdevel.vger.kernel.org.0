Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6537918B89F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 15:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgCSOHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 10:07:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33358 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgCSOHI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:07:08 -0400
Received: by mail-qt1-f193.google.com with SMTP id d22so1882119qtn.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 07:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kTXICrgMrw68e0abhd40Jdjkkp0/JNyNl77dhf2YEXA=;
        b=NfFMTOiQ5rUAFlZN/QwGLoP4c9XngRYKAhf61JkplyGPyU4hEEG7ng/y9vYwNNoe3h
         1HfaapLwwiPrHVrr1vg+9wfaiM/R22F2yYGogU24pEYqcKJesvAt4wi7cpQuqsMfig28
         oeXRNKuFHsi9W6j7I3ETrOkIEdo4UO1/tgc7+8cnksnrhm5yBNuJ6eI/4yAKLm5fIsWJ
         u0zdSo8kENA5Fm8Y7ATzFc/ySOpcdv0MHH8qee10EnHkY9Etq44/0abG6yyb7gl7VtSp
         YdhJyk2dP4LDGVz+hHN27R8rIb1aCW95ODPOFxdFa6fMjHNFb9WOnXDwt5V6j92fZ0Un
         UthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kTXICrgMrw68e0abhd40Jdjkkp0/JNyNl77dhf2YEXA=;
        b=QZSq2llCj9934mn58eS+xpZcUoti6DT05XvzF2sPRBdFImLUzYhXjE5ssCOaRznoMv
         TVA/RpdZp4OJO0p36b0+MPJLjurqlzBNiac4KBgvrlbZ6bLzgEc2CL680mkLsITy8JsR
         8eSk/uhKVgny/ZPvmcQXOM6PiEQQNM9FX/Tn9Yo2Yvo1i6wjs2OvZK5zGs207tqnreKH
         MpwMpOq4Io4u43X5fjfIlNqx0bWaVJEwYRNjxTUiAuJjsvyeMsMT8yKYEkdiSMcleJ0T
         3XHpj9yPrZuGZbrcmHrUQaPTFz24InLaYXoEbdqX/SSSjKGmIJ9976rmtyQRBKnkCVMa
         colg==
X-Gm-Message-State: ANhLgQ00cikZDI9oI+XNAv/EXuopBGgrc1Bu2XbALg0Siw4Gr57A0R10
        aiUYgFOU9DqnmAXNdphm1tY=
X-Google-Smtp-Source: ADFU+vsA59VqcLiaAfYoaJoxARN8kxS5I+YJ08EM5/NBXRw6bqKDxph1OV1vbf1bWaiwvxof8WTGAg==
X-Received: by 2002:ac8:1608:: with SMTP id p8mr3094427qtj.123.1584626826049;
        Thu, 19 Mar 2020 07:07:06 -0700 (PDT)
Received: from localhost.localdomain ([198.52.167.216])
        by smtp.gmail.com with ESMTPSA id i28sm1618917qtc.57.2020.03.19.07.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 07:07:05 -0700 (PDT)
From:   Aravind Ceyardass <aravind.pub@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        Aravind Ceyardass <aravind.pub@gmail.com>
Subject: [PATCH] staging: exfat: Fix checkpatch.pl camelcase issues
Date:   Thu, 19 Mar 2020 10:06:47 -0400
Message-Id: <20200319140647.3926-1-aravind.pub@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix ffsCamelCase function names and mixed case enums

Signed-off-by: Aravind Ceyardass <aravind.pub@gmail.com>
---
 drivers/staging/exfat/TODO          |   1 -
 drivers/staging/exfat/exfat.h       |  12 +-
 drivers/staging/exfat/exfat_super.c | 222 ++++++++++++++--------------
 3 files changed, 117 insertions(+), 118 deletions(-)

diff --git a/drivers/staging/exfat/TODO b/drivers/staging/exfat/TODO
index a283ce534cf4..51019e4431d8 100644
--- a/drivers/staging/exfat/TODO
+++ b/drivers/staging/exfat/TODO
@@ -4,7 +4,6 @@ require more work than the average checkpatch cleanup...
 Note that some of these entries may not be bugs - they're things
 that need to be looked at, and *possibly* fixed.
 
-Clean up the ffsCamelCase function names.
 
 Fix (thing)->flags to not use magic numbers - multiple offenders
 
diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 4a0a481fe010..92aac0d86249 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -227,11 +227,11 @@ struct date_time_t {
 };
 
 struct vol_info_t {
-	u32      FatType;
-	u32      ClusterSize;
-	u32      NumClusters;
-	u32      FreeClusters;
-	u32      UsedClusters;
+	u32      fat_type;
+	u32      cluster_size;
+	u32      num_clusters;
+	u32      free_clusters;
+	u32      used_clusters;
 };
 
 /* directory structure */
@@ -257,7 +257,7 @@ struct file_id_t {
 struct dir_entry_t {
 	char name[MAX_NAME_LENGTH * MAX_CHARSET_SIZE];
 	u32 attr;
-	u64 Size;
+	u64 size;
 	u32 num_subdirs;
 	struct date_time_t create_timestamp;
 	struct date_time_t modify_timestamp;
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index c7bc07e91c45..46e791ac9135 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -343,7 +343,7 @@ static inline void exfat_save_attr(struct inode *inode, u32 attr)
 		EXFAT_I(inode)->fid.attr = attr & (ATTR_RWMASK | ATTR_READONLY);
 }
 
-static int ffsMountVol(struct super_block *sb)
+static int ffs_mount_vol(struct super_block *sb)
 {
 	int i, ret;
 	struct pbr_sector_t *p_pbr;
@@ -439,7 +439,7 @@ static int ffsMountVol(struct super_block *sb)
 	return ret;
 }
 
-static int ffsUmountVol(struct super_block *sb)
+static int ffs_umount_vol(struct super_block *sb)
 {
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	int err = 0;
@@ -479,7 +479,7 @@ static int ffsUmountVol(struct super_block *sb)
 	return err;
 }
 
-static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
+static int ffs_get_vol_info(struct super_block *sb, struct vol_info_t *info)
 {
 	int err = 0;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
@@ -494,11 +494,11 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 	if (p_fs->used_clusters == UINT_MAX)
 		p_fs->used_clusters = exfat_count_used_clusters(sb);
 
-	info->FatType = EXFAT;
-	info->ClusterSize = p_fs->cluster_size;
-	info->NumClusters = p_fs->num_clusters - 2; /* clu 0 & 1 */
-	info->UsedClusters = p_fs->used_clusters;
-	info->FreeClusters = info->NumClusters - info->UsedClusters;
+	info->fat_type = EXFAT;
+	info->cluster_size = p_fs->cluster_size;
+	info->num_clusters = p_fs->num_clusters - 2; /* clu 0 & 1 */
+	info->used_clusters = p_fs->used_clusters;
+	info->free_clusters = info->num_clusters - info->used_clusters;
 
 	if (p_fs->dev_ejected)
 		err = -EIO;
@@ -509,7 +509,7 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 	return err;
 }
 
-static int ffsSyncVol(struct super_block *sb, bool do_sync)
+static int ffs_sync_vol(struct super_block *sb, bool do_sync)
 {
 	int err = 0;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
@@ -534,7 +534,7 @@ static int ffsSyncVol(struct super_block *sb, bool do_sync)
 /*  File Operation Functions                                            */
 /*----------------------------------------------------------------------*/
 
-static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
+static int ffs_lookup_file(struct inode *inode, char *path, struct file_id_t *fid)
 {
 	int ret, dentry, num_entries;
 	struct chain_t dir;
@@ -619,7 +619,7 @@ static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
 	return ret;
 }
 
-static int ffsCreateFile(struct inode *inode, char *path, u8 mode,
+static int ffs_create_file(struct inode *inode, char *path, u8 mode,
 			 struct file_id_t *fid)
 {
 	struct chain_t dir;
@@ -660,7 +660,7 @@ static int ffsCreateFile(struct inode *inode, char *path, u8 mode,
 	return ret;
 }
 
-static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
+static int ffs_truncate_file(struct inode *inode, u64 old_size, u64 new_size)
 {
 	s32 num_clusters;
 	u32 last_clu = CLUSTER_32(0);
@@ -796,7 +796,7 @@ static void update_parent_info(struct file_id_t *fid,
 	}
 }
 
-static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
+static int ffs_move_file(struct inode *old_parent_inode, struct file_id_t *fid,
 		       struct inode *new_parent_inode, struct dentry *new_dentry)
 {
 	s32 ret;
@@ -917,7 +917,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 	return ret;
 }
 
-static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
+static int ffs_remove_file(struct inode *inode, struct file_id_t *fid)
 {
 	s32 dentry;
 	int ret = 0;
@@ -981,7 +981,7 @@ static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
 
 #if 0
 /* Not currently wired up */
-static int ffsSetAttr(struct inode *inode, u32 attr)
+static int ffs_set_attr(struct inode *inode, u32 attr)
 {
 	u32 type;
 	int ret = 0;
@@ -1056,7 +1056,7 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 }
 #endif
 
-static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
+static int ffs_read_stat(struct inode *inode, struct dir_entry_t *info)
 {
 	s32 count;
 	int ret = 0;
@@ -1092,10 +1092,10 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 
 			if (p_fs->root_dir == CLUSTER_32(0)) {
 				/* FAT16 root_dir */
-				info->Size = p_fs->dentries_in_root <<
+				info->size = p_fs->dentries_in_root <<
 						DENTRY_SIZE_BITS;
 			} else {
-				info->Size = count_num_clusters(sb, &dir) <<
+				info->size = count_num_clusters(sb, &dir) <<
 						p_fs->cluster_size_bits;
 			}
 
@@ -1154,7 +1154,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 
 	info->num_subdirs = 2;
 
-	info->Size = exfat_get_entry_size(ep2);
+	info->size = exfat_get_entry_size(ep2);
 
 	release_entry_set(es);
 
@@ -1162,8 +1162,8 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 		dir.dir = fid->start_clu;
 		dir.flags = 0x01;
 
-		if (info->Size == 0)
-			info->Size = (u64)count_num_clusters(sb, &dir) <<
+		if (info->size == 0)
+			info->size = (u64)count_num_clusters(sb, &dir) <<
 					p_fs->cluster_size_bits;
 
 		count = count_dir_entries(sb, &dir);
@@ -1185,7 +1185,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	return ret;
 }
 
-static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
+static int ffs_write_stat(struct inode *inode, struct dir_entry_t *info)
 {
 	int ret = 0;
 	struct timestamp_t tm;
@@ -1241,7 +1241,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	tm.year = info->modify_timestamp.year;
 	exfat_set_entry_time(ep, &tm, TM_MODIFY);
 
-	exfat_set_entry_size(ep2, info->Size);
+	exfat_set_entry_size(ep2, info->size);
 
 	update_dir_checksum_with_entry_set(sb, es);
 	release_entry_set(es);
@@ -1258,7 +1258,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	return ret;
 }
 
-static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
+static int ffs_map_cluster(struct inode *inode, s32 clu_offset, u32 *clu)
 {
 	s32 num_clusters, num_alloced;
 	bool modified = false;
@@ -1396,7 +1396,7 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 /*  Directory Operation Functions                                       */
 /*----------------------------------------------------------------------*/
 
-static int ffsCreateDir(struct inode *inode, char *path, struct file_id_t *fid)
+static int ffs_create_dir(struct inode *inode, char *path, struct file_id_t *fid)
 {
 	int ret = 0;
 	struct chain_t dir;
@@ -1436,7 +1436,7 @@ static int ffsCreateDir(struct inode *inode, char *path, struct file_id_t *fid)
 	return ret;
 }
 
-static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
+static int ffs_read_dir(struct inode *inode, struct dir_entry_t *dir_entry)
 {
 	int i, dentry, clu_offset;
 	int ret = 0;
@@ -1574,7 +1574,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 				goto out;
 			}
 
-			dir_entry->Size = exfat_get_entry_size(ep);
+			dir_entry->size = exfat_get_entry_size(ep);
 
 			/* hint information */
 			if (dir.dir == CLUSTER_32(0)) { /* FAT16 root_dir */
@@ -1622,7 +1622,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 	return ret;
 }
 
-static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
+static int ffs_remove_dir(struct inode *inode, struct file_id_t *fid)
 {
 	s32 dentry;
 	int ret = 0;
@@ -1722,7 +1722,7 @@ static int exfat_readdir(struct file *filp, struct dir_context *ctx)
 	EXFAT_I(inode)->fid.size = i_size_read(inode);
 	EXFAT_I(inode)->fid.rwoffset = cpos >> DENTRY_SIZE_BITS;
 
-	err = ffsReadDir(inode, &de);
+	err = ffs_read_dir(inode, &de);
 	if (err) {
 		/* at least we tried to read a sector
 		 * move cpos to next sector position (should be aligned)
@@ -1836,7 +1836,7 @@ static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 
 	pr_debug("%s entered\n", __func__);
 
-	err = ffsCreateFile(dir, (u8 *)dentry->d_name.name, FM_REGULAR, &fid);
+	err = ffs_create_file(dir, (u8 *)dentry->d_name.name, FM_REGULAR, &fid);
 	if (err)
 		goto out;
 
@@ -1883,7 +1883,7 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	if (qname->len == 0)
 		return -ENOENT;
 
-	err = ffsLookupFile(dir, (u8 *)qname->name, fid);
+	err = ffs_lookup_file(dir, (u8 *)qname->name, fid);
 	if (err)
 		return -ENOENT;
 
@@ -1990,7 +1990,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 
 	EXFAT_I(inode)->fid.size = i_size_read(inode);
 
-	err = ffsRemoveFile(dir, &(EXFAT_I(inode)->fid));
+	err = ffs_remove_file(dir, &(EXFAT_I(inode)->fid));
 	if (err)
 		goto out;
 
@@ -2029,7 +2029,7 @@ static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 
 	pr_debug("%s entered\n", __func__);
 
-	err = ffsCreateDir(dir, (u8 *)dentry->d_name.name, &fid);
+	err = ffs_create_dir(dir, (u8 *)dentry->d_name.name, &fid);
 	if (err)
 		goto out;
 
@@ -2080,7 +2080,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 
 	EXFAT_I(inode)->fid.size = i_size_read(inode);
 
-	err = ffsRemoveDir(dir, &(EXFAT_I(inode)->fid));
+	err = ffs_remove_dir(dir, &(EXFAT_I(inode)->fid));
 	if (err)
 		goto out;
 
@@ -2129,7 +2129,7 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	EXFAT_I(old_inode)->fid.size = i_size_read(old_inode);
 
-	err = ffsMoveFile(old_dir, &(EXFAT_I(old_inode)->fid), new_dir,
+	err = ffs_move_file(old_dir, &(EXFAT_I(old_inode)->fid), new_dir,
 			  new_dentry);
 	if (err)
 		goto out;
@@ -2287,7 +2287,7 @@ static void exfat_truncate(struct inode *inode, loff_t old_size)
 	if (EXFAT_I(inode)->fid.start_clu == 0)
 		goto out;
 
-	err = ffsTruncateFile(inode, old_size, i_size_read(inode));
+	err = ffs_truncate_file(inode, old_size, i_size_read(inode));
 	if (err)
 		goto out;
 
@@ -2422,7 +2422,7 @@ static int exfat_file_release(struct inode *inode, struct file *filp)
 	struct super_block *sb = inode->i_sb;
 
 	EXFAT_I(inode)->fid.size = i_size_read(inode);
-	ffsSyncVol(sb, false);
+	ffs_sync_vol(sb, false);
 	return 0;
 }
 
@@ -2477,7 +2477,7 @@ static int exfat_bmap(struct inode *inode, sector_t sector, sector_t *phys,
 
 	EXFAT_I(inode)->fid.size = i_size_read(inode);
 
-	err = ffsMapCluster(inode, clu_offset, &cluster);
+	err = ffs_map_cluster(inode, clu_offset, &cluster);
 
 	if (!err && (cluster != CLUSTER_32(~0))) {
 		*phys = START_SECTOR(cluster) + sec_offset;
@@ -2670,7 +2670,7 @@ static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
 
 	memcpy(&(EXFAT_I(inode)->fid), fid, sizeof(struct file_id_t));
 
-	ffsReadStat(inode, &info);
+	ffs_read_stat(inode, &info);
 
 	EXFAT_I(inode)->i_pos = 0;
 	EXFAT_I(inode)->target = NULL;
@@ -2685,7 +2685,7 @@ static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
 		inode->i_op = &exfat_dir_inode_operations;
 		inode->i_fop = &exfat_dir_operations;
 
-		i_size_write(inode, info.Size);
+		i_size_write(inode, info.size);
 		EXFAT_I(inode)->mmu_private = i_size_read(inode);
 		set_nlink(inode, info.num_subdirs);
 	} else if (info.attr & ATTR_SYMLINK) { /* symbolic link */
@@ -2693,7 +2693,7 @@ static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
 		inode->i_mode = exfat_make_mode(sbi, info.attr, 0777);
 		inode->i_op = &exfat_symlink_inode_operations;
 
-		i_size_write(inode, info.Size);
+		i_size_write(inode, info.size);
 		EXFAT_I(inode)->mmu_private = i_size_read(inode);
 	} else { /* regular file */
 		inode->i_generation |= 1;
@@ -2703,7 +2703,7 @@ static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
 		inode->i_mapping->a_ops = &exfat_aops;
 		inode->i_mapping->nrpages = 0;
 
-		i_size_write(inode, info.Size);
+		i_size_write(inode, info.size);
 		EXFAT_I(inode)->mmu_private = i_size_read(inode);
 	}
 	exfat_save_attr(inode, info.attr);
@@ -2780,13 +2780,13 @@ static int exfat_write_inode(struct inode *inode, struct writeback_control *wbc)
 		return 0;
 
 	info.attr = exfat_make_attr(inode);
-	info.Size = i_size_read(inode);
+	info.size = i_size_read(inode);
 
 	exfat_time_unix2fat(&inode->i_mtime, &info.modify_timestamp);
 	exfat_time_unix2fat(&inode->i_ctime, &info.create_timestamp);
 	exfat_time_unix2fat(&inode->i_atime, &info.access_timestamp);
 
-	ffsWriteStat(inode, &info);
+	ffs_write_stat(inode, &info);
 
 	return 0;
 }
@@ -2824,7 +2824,7 @@ static void exfat_put_super(struct super_block *sb)
 	if (__is_sb_dirty(sb))
 		exfat_write_super(sb);
 
-	ffsUmountVol(sb);
+	ffs_umount_vol(sb);
 
 	sb->s_fs_info = NULL;
 	exfat_free_super(sbi);
@@ -2837,7 +2837,7 @@ static void exfat_write_super(struct super_block *sb)
 	__set_sb_clean(sb);
 
 	if (!sb_rdonly(sb))
-		ffsSyncVol(sb, true);
+		ffs_sync_vol(sb, true);
 
 	__unlock_super(sb);
 }
@@ -2849,7 +2849,7 @@ static int exfat_sync_fs(struct super_block *sb, int wait)
 	if (__is_sb_dirty(sb)) {
 		__lock_super(sb);
 		__set_sb_clean(sb);
-		err = ffsSyncVol(sb, true);
+		err = ffs_sync_vol(sb, true);
 		__unlock_super(sb);
 	}
 
@@ -2864,25 +2864,25 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct vol_info_t info;
 
 	if (p_fs->used_clusters == UINT_MAX) {
-		if (ffsGetVolInfo(sb, &info) == -EIO)
+		if (ffs_get_vol_info(sb, &info) == -EIO)
 			return -EIO;
 
 	} else {
-		info.FatType = EXFAT;
-		info.ClusterSize = p_fs->cluster_size;
-		info.NumClusters = p_fs->num_clusters - 2;
-		info.UsedClusters = p_fs->used_clusters;
-		info.FreeClusters = info.NumClusters - info.UsedClusters;
+		info.fat_type = EXFAT;
+		info.cluster_size = p_fs->cluster_size;
+		info.num_clusters = p_fs->num_clusters - 2;
+		info.used_clusters = p_fs->used_clusters;
+		info.free_clusters = info.num_clusters - info.used_clusters;
 
 		if (p_fs->dev_ejected)
 			pr_info("[EXFAT] statfs on device that is ejected\n");
 	}
 
 	buf->f_type = sb->s_magic;
-	buf->f_bsize = info.ClusterSize;
-	buf->f_blocks = info.NumClusters;
-	buf->f_bfree = info.FreeClusters;
-	buf->f_bavail = info.FreeClusters;
+	buf->f_bsize = info.cluster_size;
+	buf->f_blocks = info.num_clusters;
+	buf->f_bfree = info.free_clusters;
+	buf->f_bavail = info.free_clusters;
 	buf->f_fsid.val[0] = (u32)id;
 	buf->f_fsid.val[1] = (u32)(id >> 32);
 	buf->f_namelen = 260;
@@ -2986,45 +2986,45 @@ static const struct export_operations exfat_export_ops = {
 /*======================================================================*/
 
 enum {
-	Opt_uid,
-	Opt_gid,
-	Opt_umask,
-	Opt_dmask,
-	Opt_fmask,
-	Opt_allow_utime,
-	Opt_codepage,
-	Opt_charset,
-	Opt_namecase,
-	Opt_debug,
-	Opt_err_cont,
-	Opt_err_panic,
-	Opt_err_ro,
-	Opt_utf8_hack,
-	Opt_err,
+	OPT_UID,
+	OPT_GID,
+	OPT_UMASK,
+	OPT_DMASK,
+	OPT_FMASK,
+	OPT_ALLOW_UTIME,
+	OPT_CODEPAGE,
+	OPT_CHARSET,
+	OPT_NAMECASE,
+	OPT_DEBUG,
+	OPT_ERR_CONT,
+	OPT_ERR_PANIC,
+	OPT_ERR_RO,
+	OPT_UTF8_HACK,
+	OPT_ERR,
 #ifdef CONFIG_STAGING_EXFAT_DISCARD
-	Opt_discard,
+	OPT_DISCARD,
 #endif /* EXFAT_CONFIG_DISCARD */
 };
 
 static const match_table_t exfat_tokens = {
-	{Opt_uid, "uid=%u"},
-	{Opt_gid, "gid=%u"},
-	{Opt_umask, "umask=%o"},
-	{Opt_dmask, "dmask=%o"},
-	{Opt_fmask, "fmask=%o"},
-	{Opt_allow_utime, "allow_utime=%o"},
-	{Opt_codepage, "codepage=%u"},
-	{Opt_charset, "iocharset=%s"},
-	{Opt_namecase, "namecase=%u"},
-	{Opt_debug, "debug"},
-	{Opt_err_cont, "errors=continue"},
-	{Opt_err_panic, "errors=panic"},
-	{Opt_err_ro, "errors=remount-ro"},
-	{Opt_utf8_hack, "utf8"},
+	{OPT_UID, "uid=%u"},
+	{OPT_GID, "gid=%u"},
+	{OPT_UMASK, "umask=%o"},
+	{OPT_DMASK, "dmask=%o"},
+	{OPT_FMASK, "fmask=%o"},
+	{OPT_ALLOW_UTIME, "allow_utime=%o"},
+	{OPT_CODEPAGE, "codepage=%u"},
+	{OPT_CHARSET, "iocharset=%s"},
+	{OPT_NAMECASE, "namecase=%u"},
+	{OPT_DEBUG, "debug"},
+	{OPT_ERR_CONT, "errors=continue"},
+	{OPT_ERR_PANIC, "errors=panic"},
+	{OPT_ERR_RO, "errors=remount-ro"},
+	{OPT_UTF8_HACK, "utf8"},
 #ifdef CONFIG_STAGING_EXFAT_DISCARD
-	{Opt_discard, "discard"},
+	{OPT_DISCARD, "discard"},
 #endif /* CONFIG_STAGING_EXFAT_DISCARD */
-	{Opt_err, NULL}
+	{OPT_ERR, NULL}
 };
 
 static int parse_options(char *options, int silent, int *debug,
@@ -3060,37 +3060,37 @@ static int parse_options(char *options, int silent, int *debug,
 
 		token = match_token(p, exfat_tokens, args);
 		switch (token) {
-		case Opt_uid:
+		case OPT_UID:
 			if (match_int(&args[0], &option))
 				return 0;
 			opts->fs_uid = KUIDT_INIT(option);
 			break;
-		case Opt_gid:
+		case OPT_GID:
 			if (match_int(&args[0], &option))
 				return 0;
 			opts->fs_gid = KGIDT_INIT(option);
 			break;
-		case Opt_umask:
-		case Opt_dmask:
-		case Opt_fmask:
+		case OPT_UMASK:
+		case OPT_DMASK:
+		case OPT_FMASK:
 			if (match_octal(&args[0], &option))
 				return 0;
-			if (token != Opt_dmask)
+			if (token != OPT_DMASK)
 				opts->fs_fmask = option;
-			if (token != Opt_fmask)
+			if (token != OPT_FMASK)
 				opts->fs_dmask = option;
 			break;
-		case Opt_allow_utime:
+		case OPT_ALLOW_UTIME:
 			if (match_octal(&args[0], &option))
 				return 0;
 			opts->allow_utime = option & 0022;
 			break;
-		case Opt_codepage:
+		case OPT_CODEPAGE:
 			if (match_int(&args[0], &option))
 				return 0;
 			opts->codepage = option;
 			break;
-		case Opt_charset:
+		case OPT_CHARSET:
 			if (opts->iocharset != exfat_default_iocharset)
 				kfree(opts->iocharset);
 			iocharset = match_strdup(&args[0]);
@@ -3098,29 +3098,29 @@ static int parse_options(char *options, int silent, int *debug,
 				return -ENOMEM;
 			opts->iocharset = iocharset;
 			break;
-		case Opt_namecase:
+		case OPT_NAMECASE:
 			if (match_int(&args[0], &option))
 				return 0;
 			opts->casesensitive = option;
 			break;
-		case Opt_err_cont:
+		case OPT_ERR_CONT:
 			opts->errors = EXFAT_ERRORS_CONT;
 			break;
-		case Opt_err_panic:
+		case OPT_ERR_PANIC:
 			opts->errors = EXFAT_ERRORS_PANIC;
 			break;
-		case Opt_err_ro:
+		case OPT_ERR_RO:
 			opts->errors = EXFAT_ERRORS_RO;
 			break;
-		case Opt_debug:
+		case OPT_DEBUG:
 			*debug = 1;
 			break;
 #ifdef CONFIG_STAGING_EXFAT_DISCARD
-		case Opt_discard:
+		case OPT_DISCARD:
 			opts->discard = 1;
 			break;
 #endif /* CONFIG_STAGING_EXFAT_DISCARD */
-		case Opt_utf8_hack:
+		case OPT_UTF8_HACK:
 			break;
 		default:
 			if (!silent)
@@ -3166,7 +3166,7 @@ static int exfat_read_root(struct inode *inode)
 
 	EXFAT_I(inode)->target = NULL;
 
-	ffsReadStat(inode, &info);
+	ffs_read_stat(inode, &info);
 
 	inode->i_uid = sbi->options.fs_uid;
 	inode->i_gid = sbi->options.fs_gid;
@@ -3176,7 +3176,7 @@ static int exfat_read_root(struct inode *inode)
 	inode->i_op = &exfat_dir_inode_operations;
 	inode->i_fop = &exfat_dir_operations;
 
-	i_size_write(inode, info.Size);
+	i_size_write(inode, info.size);
 	inode->i_blocks = ((i_size_read(inode) + (p_fs->cluster_size - 1))
 				& ~((loff_t)p_fs->cluster_size - 1)) >> 9;
 	EXFAT_I(inode)->i_pos = ((loff_t)p_fs->root_dir << 32) | 0xffffffff;
@@ -3233,10 +3233,10 @@ static int exfat_fill_super(struct super_block *sb, void *data, int silent)
 	sb_min_blocksize(sb, 512);
 	sb->s_maxbytes = 0x7fffffffffffffffLL;    /* maximum file size */
 
-	ret = ffsMountVol(sb);
+	ret = ffs_mount_vol(sb);
 	if (ret) {
 		if (!silent)
-			pr_err("[EXFAT] ffsMountVol failed\n");
+			pr_err("[EXFAT] ffs_mount_vol failed\n");
 
 		goto out_fail;
 	}
@@ -3276,7 +3276,7 @@ static int exfat_fill_super(struct super_block *sb, void *data, int silent)
 	return 0;
 
 out_fail2:
-	ffsUmountVol(sb);
+	ffs_umount_vol(sb);
 out_fail:
 	if (root_inode)
 		iput(root_inode);
-- 
2.21.1

