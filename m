Return-Path: <linux-fsdevel+bounces-71801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8713CD35DF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 20:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51C11300F326
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 19:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA012D1916;
	Sat, 20 Dec 2025 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Fx18a5YM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CAE275106
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Dec 2025 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766257870; cv=none; b=X59zqi99IJPeZZyUQiPXs9AnvV/LJf4kBAeOoRzzqkvBnpzF21WLIY3Vn+oDpQbAsScOwWoxhp/kx3i/zqTKAcXdqFT2W0ZBA16AQuLdC/pYMUGA+DbnMamOjnhK/bGuRqlTF8Kp5c6BDSjApMt/ylKu19P/aK54+SXnVEHgQeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766257870; c=relaxed/simple;
	bh=NVW944617t2CcRAM69BgtHS+tULZnfa5UwKiGgKy8X8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HYCVvSzEkb/GNYXDovK40hZhQMcCH5B5IHofCEsOq5p7DUtqjgSwB/jAmLqU24ZQjnJw988P/n7b+QJJqVZ0SafF1IyVZ4qXLZOCHoIFO/+dYX/615gWeGSmOtc/wfjLr+CufojVWl5dCoURS5DY17Shh5mjngguOZalgf+IST0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Fx18a5YM; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: db731f34-ddd7-11f0-ad1a-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id db731f34-ddd7-11f0-ad1a-005056999439;
	Sat, 20 Dec 2025 20:12:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=4/P0DcpRThtjTa2JK7rM4jTde5DkmqnXaKKTNBURABQ=;
	b=Fx18a5YMqZcHmjOkI3F3Yjb3XfbVmhjbyFo+u9JaxhLyvckK/GxuYp/6bsK3NWj5zTZc0E/YJMwcN
	 wZldluLr47B6d/M4/F1U9YiRjdv2wY6xqUaFrVEViP7/MMbF7vOaVHAH8M/B1TKnuQeaK/eKtXJhc+
	 eDgPXzXkt8td9fF30b0yunRY0n5yjBk9GrcmjlfDkIs2Bo4XPInTr9KV2Y5CWVHZB0VFGji8HvOWOE
	 3mEqBkALoMbhROuf0zwDhyFXWjeXsslRBnxu8NE4pNTXbvJA+HhFLgXMaI8BxFyIMwcavrmbxewBm5
	 tqhgoaUVDIV2yjfcxTJ/vlEXonL4dFg==
X-KPN-MID: 33|wnvTeqXSx4/BUNnM8DOseVTDQaDCT7cmcEwjs2XJsaMzqkdsVLcDvTM6OmJWcH3
 bNCFj6nyBtuav+ZCg/y3fJlrvLIm8XB0y6YMxFBwLObM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Emgz+fTUna8F+nMtqJDKNCPmt6TfR3Hn5aGR+6pcPl5sNAZCO8uDrWSfiQP+GVk
 VSzdv3W2b7MSGCwAP+47EkA==
Received: from daedalus.home (unknown [91.141.147.86])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 73f2c0f3-ddd7-11f0-86c9-005056998788;
	Sat, 20 Dec 2025 20:09:57 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com
Subject: [PATCH v4] hfs: Replace BUG_ON with error handling for CNID count checks
Date: Sat, 20 Dec 2025 20:10:06 +0100
Message-ID: <20251220191006.2465256-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a06ec283e125 next_id, folder_count, and file_count in the super block
info were expanded to 64 bits, and BUG_ONs were added to detect
overflow. This triggered an error reported by syzbot: if the MDB is
corrupted, the BUG_ON is triggered. This patch replaces this mechanism
with proper error handling and resolves the syzbot reported bug.

Singed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
Reported-by: syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=17cc9bb6d8d69b4139f0
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
Changes from v3:
Removed some redunancy in the count overflow error in hfs_remove, and
a ;; typo.

Changes from v2:
There is now a is_hfs_cnid_counts_valid() function that checks several
CNID counts in the hfs super block info which can overflow. This check
is performed in hfs_mdb_get(), when syncing, and when doing the
mdb_flush(). Overall, effort is taken for the checks to be as
non-intrusive as possible. So the mdb continues to flush, but warnings
are printed, instead of stopping fully, so not to derail the fs
operation too much.

When loading the mdb from disk however, we can be sure there is disk
corruption when is_hfs_cnid_counts_valid() is triggered. In that case we
mount RO.

Also, instead of returning EFSCORRUPTED, we return ERANGE.
---
 fs/hfs/dir.c    | 15 +++++++++++----
 fs/hfs/hfs_fs.h |  1 +
 fs/hfs/inode.c  | 30 ++++++++++++++++++++++++------
 fs/hfs/mdb.c    | 31 +++++++++++++++++++++++++++----
 fs/hfs/super.c  |  3 +++
 5 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 86a6b317b474..0c615c078650 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -196,8 +196,8 @@ static int hfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	int res;
 
 	inode = hfs_new_inode(dir, &dentry->d_name, mode);
-	if (!inode)
-		return -ENOMEM;
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
 
 	res = hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
 	if (res) {
@@ -226,8 +226,8 @@ static struct dentry *hfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	int res;
 
 	inode = hfs_new_inode(dir, &dentry->d_name, S_IFDIR | mode);
-	if (!inode)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
 
 	res = hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
 	if (res) {
@@ -254,11 +254,18 @@ static struct dentry *hfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
  */
 static int hfs_remove(struct inode *dir, struct dentry *dentry)
 {
+	struct super_block *sb = dir->i_sb;
 	struct inode *inode = d_inode(dentry);
 	int res;
 
 	if (S_ISDIR(inode->i_mode) && inode->i_size != 2)
 		return -ENOTEMPTY;
+
+	if (unlikely(!is_hfs_cnid_counts_valid(sb))) {
+	    pr_err("cannot remove file/folder\n");
+	    return -ERANGE;
+	}
+
 	res = hfs_cat_delete(inode->i_ino, dir, &dentry->d_name);
 	if (res)
 		return res;
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index e94dbc04a1e4..ac0e83f77a0f 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -199,6 +199,7 @@ extern void hfs_delete_inode(struct inode *inode);
 extern const struct xattr_handler * const hfs_xattr_handlers[];
 
 /* mdb.c */
+extern bool is_hfs_cnid_counts_valid(struct super_block *sb);
 extern int hfs_mdb_get(struct super_block *sb);
 extern void hfs_mdb_commit(struct super_block *sb);
 extern void hfs_mdb_close(struct super_block *sb);
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 524db1389737..878535db64d6 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -187,16 +187,23 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	s64 next_id;
 	s64 file_count;
 	s64 folder_count;
+	int err = -ENOMEM;
 
 	if (!inode)
-		return NULL;
+		goto out_err;
+
+	err = -ERANGE;
 
 	mutex_init(&HFS_I(inode)->extents_lock);
 	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
 	spin_lock_init(&HFS_I(inode)->open_dir_lock);
 	hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, name);
 	next_id = atomic64_inc_return(&HFS_SB(sb)->next_id);
-	BUG_ON(next_id > U32_MAX);
+	if (next_id > U32_MAX) {
+		atomic64_dec(&HFS_SB(sb)->next_id);
+		pr_err("cannot create new inode: next CNID exceeds limit\n");
+		goto out_discard;
+	}
 	inode->i_ino = (u32)next_id;
 	inode->i_mode = mode;
 	inode->i_uid = current_fsuid();
@@ -210,7 +217,11 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	if (S_ISDIR(mode)) {
 		inode->i_size = 2;
 		folder_count = atomic64_inc_return(&HFS_SB(sb)->folder_count);
-		BUG_ON(folder_count > U32_MAX);
+		if (folder_count> U32_MAX) {
+			atomic64_dec(&HFS_SB(sb)->folder_count);
+			pr_err("cannot create new inode: folder count exceeds limit\n");
+			goto out_discard;
+		}
 		if (dir->i_ino == HFS_ROOT_CNID)
 			HFS_SB(sb)->root_dirs++;
 		inode->i_op = &hfs_dir_inode_operations;
@@ -220,7 +231,11 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	} else if (S_ISREG(mode)) {
 		HFS_I(inode)->clump_blocks = HFS_SB(sb)->clumpablks;
 		file_count = atomic64_inc_return(&HFS_SB(sb)->file_count);
-		BUG_ON(file_count > U32_MAX);
+		if (file_count > U32_MAX) {
+			atomic64_dec(&HFS_SB(sb)->file_count);
+			pr_err("cannot create new inode: file count exceeds limit\n");
+			goto out_discard;
+		}
 		if (dir->i_ino == HFS_ROOT_CNID)
 			HFS_SB(sb)->root_files++;
 		inode->i_op = &hfs_file_inode_operations;
@@ -244,6 +259,11 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	hfs_mark_mdb_dirty(sb);
 
 	return inode;
+
+	out_discard:
+		iput(inode);
+	out_err:
+		return ERR_PTR(err);
 }
 
 void hfs_delete_inode(struct inode *inode)
@@ -252,7 +272,6 @@ void hfs_delete_inode(struct inode *inode)
 
 	hfs_dbg("ino %lu\n", inode->i_ino);
 	if (S_ISDIR(inode->i_mode)) {
-		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
 		atomic64_dec(&HFS_SB(sb)->folder_count);
 		if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
 			HFS_SB(sb)->root_dirs--;
@@ -261,7 +280,6 @@ void hfs_delete_inode(struct inode *inode)
 		return;
 	}
 
-	BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
 	atomic64_dec(&HFS_SB(sb)->file_count);
 	if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
 		HFS_SB(sb)->root_files--;
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 53f3fae60217..e0150945cf13 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -64,6 +64,27 @@ static int hfs_get_last_session(struct super_block *sb,
 	return 0;
 }
 
+bool is_hfs_cnid_counts_valid(struct super_block *sb)
+{
+	struct hfs_sb_info *sbi = HFS_SB(sb);
+	bool corrupted = false;
+
+	if (unlikely(atomic64_read(&sbi->next_id) > U32_MAX)) {
+		pr_warn("next CNID exceeds limit\n");
+		corrupted = true;
+	}
+	if (unlikely(atomic64_read(&sbi->file_count) > U32_MAX)) {
+		pr_warn("file count exceeds limit\n");
+		corrupted = true;
+	}
+	if (unlikely(atomic64_read(&sbi->folder_count) > U32_MAX)) {
+		pr_warn("folder count exceeds limit\n");
+		corrupted = true;
+	}
+
+	return !corrupted;
+}
+
 /*
  * hfs_mdb_get()
  *
@@ -156,6 +177,11 @@ int hfs_mdb_get(struct super_block *sb)
 	atomic64_set(&HFS_SB(sb)->file_count, be32_to_cpu(mdb->drFilCnt));
 	atomic64_set(&HFS_SB(sb)->folder_count, be32_to_cpu(mdb->drDirCnt));
 
+	if (!is_hfs_cnid_counts_valid(sb)) {
+		pr_warn("filesystem possibly corrupted, running fsck.hfs is recommended. Mounting read-only.\n");
+		sb->s_flags |= SB_RDONLY;
+	}
+
 	/* TRY to get the alternate (backup) MDB. */
 	sect = part_start + part_size - 2;
 	bh = sb_bread512(sb, sect, mdb2);
@@ -209,7 +235,7 @@ int hfs_mdb_get(struct super_block *sb)
 
 	attrib = mdb->drAtrb;
 	if (!(attrib & cpu_to_be16(HFS_SB_ATTRIB_UNMNT))) {
-		pr_warn("filesystem was not cleanly unmounted, running fsck.hfs is recommended.  mounting read-only.\n");
+		pr_warn("filesystem was not cleanly unmounted, running fsck.hfs is recommended.	Mounting read-only.\n");
 		sb->s_flags |= SB_RDONLY;
 	}
 	if ((attrib & cpu_to_be16(HFS_SB_ATTRIB_SLOCK))) {
@@ -273,15 +299,12 @@ void hfs_mdb_commit(struct super_block *sb)
 		/* These parameters may have been modified, so write them back */
 		mdb->drLsMod = hfs_mtime();
 		mdb->drFreeBks = cpu_to_be16(HFS_SB(sb)->free_ablocks);
-		BUG_ON(atomic64_read(&HFS_SB(sb)->next_id) > U32_MAX);
 		mdb->drNxtCNID =
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->next_id));
 		mdb->drNmFls = cpu_to_be16(HFS_SB(sb)->root_files);
 		mdb->drNmRtDirs = cpu_to_be16(HFS_SB(sb)->root_dirs);
-		BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
 		mdb->drFilCnt =
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->file_count));
-		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
 		mdb->drDirCnt =
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->folder_count));
 
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 47f50fa555a4..70e118c27e20 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -34,6 +34,7 @@ MODULE_LICENSE("GPL");
 
 static int hfs_sync_fs(struct super_block *sb, int wait)
 {
+	is_hfs_cnid_counts_valid(sb);
 	hfs_mdb_commit(sb);
 	return 0;
 }
@@ -65,6 +66,8 @@ static void flush_mdb(struct work_struct *work)
 	sbi->work_queued = 0;
 	spin_unlock(&sbi->work_lock);
 
+	is_hfs_cnid_counts_valid(sb);
+
 	hfs_mdb_commit(sb);
 }
 
-- 
2.51.2


