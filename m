Return-Path: <linux-fsdevel+bounces-69841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C20C87304
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 22:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764F63B688B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 21:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BC22F6560;
	Tue, 25 Nov 2025 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="uPZsoVgR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A34E2EB86C
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764105226; cv=none; b=hExsqQCXNmDeVraknnkqah7btb996PwIUZKm2JYbHC/sxC/ZAj8umsWEBttwIiehNSkCmBkjlDLK7IBIfaBDaU8mlt+5TYoW0Ts9YV0lTvEIdaPro8fzSU/gNcX9UnVg/McLNjVAKbqPQGB8R/Remmi+sXvdCCX0j/qQw5N1QrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764105226; c=relaxed/simple;
	bh=RuMV7T1lsRwZvgKwUG2IbRElBI4SLUyhl8aWvBZqu3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iphkb4mEy6qUSjUnQeJFOQO5ru8bDN/N25si/AFHR2g1Of3VDQ9irOfNtZGarpGoo06X5iVxPQNNJQ4PbH9ENsfvYYtpBriaMBSmi7eHANF3Q+zJt+R31jY5BNtiIT1j/B6DqAdoh/WrUb11aDXbtW1ScTpsti7Ozp5hI14OaPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=uPZsoVgR; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: e35cc18a-ca43-11f0-9c78-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id e35cc18a-ca43-11f0-9c78-005056ab378f;
	Tue, 25 Nov 2025 22:15:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:date:subject:to:from;
	bh=XvYQBhbB2su/NQDIRlNnreV4ebeiTeHkR0s2XuDIkOk=;
	b=uPZsoVgRTJnmRJCaRwbe+Y9aTj2R9IFPnuamyAfFT2J1q+XepJYZQyiOpWlmySVVncYHn9B5A9lsa
	 MFn3MVekC7P3YCMANa72MiS+CDHHSjOaJjrjTe1nlxhRArOh6h4dmsczGLedA6yXbiIbKD8O4xU6Dh
	 hayIbgDvGE8+gUysF+VohRbheIq954hHNiK4tzVOVChboFcXQU6qd/jzo8z6QPb6uIkEM6MjgWNsQJ
	 A4f8ohlPndIYNdDkB+SNZXeNptt8iZ+7WFcz9Bl+YlzLL5SDV17ckz/E2sVqwVCJ9udk5smstngngI
	 VbYm5PKr8BQrTE8YHsYpFeEEgAEtU8g==
X-KPN-MID: 33|CmZ7cAW9IEe93QMPHVya3B4l2UXhHnXN4tIGUe2SaKeuQPoQLMvoC1zQmeV0IGP
 rI0OeKv33eQ9D+8UKGr2pAlIis4JZcrbMtPOoXLPPWfU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|pDUMv9Zp4PjEgMrFrDc4ai3FlYsQQjnaPsV0rDDZERK0YJ3YFo/FnWepsasqt8x
 Y/6Km58oRULjruKxEhGRW9w==
Received: from daedalus.home (unknown [178.228.24.129])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 9317f1aa-ca43-11f0-800a-005056ab7447;
	Tue, 25 Nov 2025 22:13:33 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	skhan@linuxfoundation.org,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com
Subject: [PATCH v2] hfs: replace BUG_ONs with error handling
Date: Tue, 25 Nov 2025 22:13:27 +0100
Message-ID: <20251125211329.2835801-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 fs/hfs/dir.c    | 12 ++++++------
 fs/hfs/hfs.h    |  3 +++
 fs/hfs/hfs_fs.h |  2 +-
 fs/hfs/inode.c  | 40 ++++++++++++++++++++++++++++++++--------
 fs/hfs/mdb.c    | 15 ++++++++++++---
 5 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 86a6b317b474..03881a91f869 100644
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
@@ -264,9 +264,9 @@ static int hfs_remove(struct inode *dir, struct dentry *dentry)
 		return res;
 	clear_nlink(inode);
 	inode_set_ctime_current(inode);
-	hfs_delete_inode(inode);
+	res = hfs_delete_inode(inode);
 	mark_inode_dirty(inode);
-	return 0;
+	return res;
 }
 
 /*
diff --git a/fs/hfs/hfs.h b/fs/hfs/hfs.h
index 6f194d0768b6..4b4797ef4e50 100644
--- a/fs/hfs/hfs.h
+++ b/fs/hfs/hfs.h
@@ -287,3 +287,6 @@ struct hfs_readdir_data {
 };
 
 #endif
+
+
+#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index fff149af89da..21dfdde71b14 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -182,7 +182,7 @@ extern void hfs_inode_read_fork(struct inode *inode, struct hfs_extent *ext,
 			__be32 log_size, __be32 phys_size, u32 clump_size);
 extern struct inode *hfs_iget(struct super_block *, struct hfs_cat_key *, hfs_cat_rec *);
 extern void hfs_evict_inode(struct inode *);
-extern void hfs_delete_inode(struct inode *);
+extern int hfs_delete_inode(struct inode *);
 
 /* attr.c */
 extern const struct xattr_handler * const hfs_xattr_handlers[];
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 9cd449913dc8..ce27d49c41e4 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -186,16 +186,22 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	s64 next_id;
 	s64 file_count;
 	s64 folder_count;
+	int err = -ENOMEM;
 
 	if (!inode)
-		return NULL;
+		goto out_err;
+
+	err = -EFSCORRUPTED;
 
 	mutex_init(&HFS_I(inode)->extents_lock);
 	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
 	spin_lock_init(&HFS_I(inode)->open_dir_lock);
 	hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, name);
 	next_id = atomic64_inc_return(&HFS_SB(sb)->next_id);
-	BUG_ON(next_id > U32_MAX);
+	if (next_id > U32_MAX) {
+		pr_err("next CNID exceeds limit — filesystem corrupted. It is recommended to run fsck\n");
+		goto out_discard;
+	}
 	inode->i_ino = (u32)next_id;
 	inode->i_mode = mode;
 	inode->i_uid = current_fsuid();
@@ -209,7 +215,10 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	if (S_ISDIR(mode)) {
 		inode->i_size = 2;
 		folder_count = atomic64_inc_return(&HFS_SB(sb)->folder_count);
-		BUG_ON(folder_count > U32_MAX);
+		if (folder_count > U32_MAX) {
+			pr_err("folder count exceeds limit — filesystem corrupted. It is recommended to run fsck\n");
+			goto out_discard;
+		}
 		if (dir->i_ino == HFS_ROOT_CNID)
 			HFS_SB(sb)->root_dirs++;
 		inode->i_op = &hfs_dir_inode_operations;
@@ -219,7 +228,10 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	} else if (S_ISREG(mode)) {
 		HFS_I(inode)->clump_blocks = HFS_SB(sb)->clumpablks;
 		file_count = atomic64_inc_return(&HFS_SB(sb)->file_count);
-		BUG_ON(file_count > U32_MAX);
+		if (file_count > U32_MAX) {
+			pr_err("file count exceeds limit — filesystem corrupted. It is recommended to run fsck\n");
+			goto out_discard;
+		}
 		if (dir->i_ino == HFS_ROOT_CNID)
 			HFS_SB(sb)->root_files++;
 		inode->i_op = &hfs_file_inode_operations;
@@ -243,24 +255,35 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	hfs_mark_mdb_dirty(sb);
 
 	return inode;
+
+	out_discard:
+		iput(inode);	
+	out_err:
+		return ERR_PTR(err); 
 }
 
-void hfs_delete_inode(struct inode *inode)
+int hfs_delete_inode(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
 	hfs_dbg("ino %lu\n", inode->i_ino);
 	if (S_ISDIR(inode->i_mode)) {
-		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
+		if (atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX) {
+			pr_err("folder count exceeds limit — filesystem corrupted. It is recommended to run fsck\n");
+			return -EFSCORRUPTED;
+		}
 		atomic64_dec(&HFS_SB(sb)->folder_count);
 		if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
 			HFS_SB(sb)->root_dirs--;
 		set_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags);
 		hfs_mark_mdb_dirty(sb);
-		return;
+		return 0;
 	}
 
-	BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
+	if (atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX) {
+		pr_err("file count exceeds limit — filesystem corrupted. It is recommended to run fsck\n");
+		return -EFSCORRUPTED;
+	}
 	atomic64_dec(&HFS_SB(sb)->file_count);
 	if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
 		HFS_SB(sb)->root_files--;
@@ -272,6 +295,7 @@ void hfs_delete_inode(struct inode *inode)
 	}
 	set_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags);
 	hfs_mark_mdb_dirty(sb);
+	return 0;
 }
 
 void hfs_inode_read_fork(struct inode *inode, struct hfs_extent *ext,
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 53f3fae60217..45b690ab4ba5 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -273,15 +273,24 @@ void hfs_mdb_commit(struct super_block *sb)
 		/* These parameters may have been modified, so write them back */
 		mdb->drLsMod = hfs_mtime();
 		mdb->drFreeBks = cpu_to_be16(HFS_SB(sb)->free_ablocks);
-		BUG_ON(atomic64_read(&HFS_SB(sb)->next_id) > U32_MAX);
+		if (atomic64_read(&HFS_SB(sb)->next_id) > U32_MAX) {
+			pr_err("next CNID exceeds limit — filesystem corrupted. It is recommended to run fsck\n");
+			return;
+		}
 		mdb->drNxtCNID =
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->next_id));
 		mdb->drNmFls = cpu_to_be16(HFS_SB(sb)->root_files);
 		mdb->drNmRtDirs = cpu_to_be16(HFS_SB(sb)->root_dirs);
-		BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
+		if (atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX) {
+			pr_err("file count exceeds limit — filesystem corrupted. It is recommended to run fsck\n");
+			return;
+		}
 		mdb->drFilCnt =
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->file_count));
-		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
+		if (atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX) {
+			pr_err("folder count exceeds limit — filesystem corrupted. It is recommended to run fsck\n");
+			return;
+		}
 		mdb->drDirCnt =
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->folder_count));
 
-- 
2.51.2


