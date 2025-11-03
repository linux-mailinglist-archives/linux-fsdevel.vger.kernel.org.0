Return-Path: <linux-fsdevel+bounces-66793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C7DC2C01F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 14:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7B9188AD28
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F62330FC35;
	Mon,  3 Nov 2025 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ZSWqYLiW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C4A30F52C
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762175461; cv=none; b=FsRV1Bw1yd/LDfBKZ5jBXoppvoTLoEJemLD0Fd1YPPtMEJ809DgI3UiXQe41TG9j2jeqJD/OrPMRyOUU6Ep2a7fThUyFt8D9NbDx0/mV2MKAG4nQTPhrPjPiN66dldK5FUFPpsNy1SrFPVVqR045cZQvScegcv9Ed1whHOoc5Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762175461; c=relaxed/simple;
	bh=mV3O6YoTTbtt6a3k+9ImmRfFRYL0sA6FKyCzYSTn/RI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CZnX/xPkb8XrsxPot4ZdlKGt6bjWuiyM/rRi9qabpPBjKcsCvpSluDowMuwYGuHunKXcf6vUlWuJyUolHz3Fx+nXk2sJOj4ibT4mEsbCmkzynZjUR/hq2gTsRCWt68IPRFOkTAZYxZ24L2I3CBg3+HzAcF+oJe5DffIFC5mNbPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ZSWqYLiW; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: c0b4fcf2-b8b6-11f0-9e68-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c0b4fcf2-b8b6-11f0-9e68-005056994fde;
	Mon, 03 Nov 2025 14:12:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:date:subject:to:from;
	bh=l7Usrm96o2oHOsUmChC9mguuKvwuyzaTHVKWoI8Pd9k=;
	b=ZSWqYLiWZoh/MidcfGVtoD4wbbsJP0ZCWzhSFrieyqych7tEtrHX6dmW67KZBhioLFB92gFmhM5Gj
	 kRjGW0L6kYhWSap+4zlv1v5vhVl3jTnmhY4o/ezNz5pmeyd/DbUECg7Qznuvb3xXhP12U+jOg3tdND
	 JO3WMA8dM3rRJ3hFA+dPSBNbIdjQRXLjADw6N/rtlsZHIgLMNivkiut2XnO/QSwhs2wfuRF3opT6HP
	 eUu3Y2tfskDWA14XFPxftciqyLGFOoFyvr66PA5ohn+v/wt0SXgTLJ1Z+12SmJefY5qwVHjr9Bx17/
	 DeZQM1uxY5IC9MlVMYPhCh1Ri8EpYIw==
X-KPN-MID: 33|zkUGKY/FfLSgk0o6V0AawcVHLeBQSLmYBGtAYcS+UOA3ylkZJKG7OCOSHXJ6rGP
 SUmsUFxzBcXPw14xcfsIhOdgITt2npFj+mt3GY2F/4Ns=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|IDPTOzr1hMML4VkWMj2OSYCMriSJ0gsQKo2Cs5Asglm9uFSv6e06ks0kWVME4hq
 D+M0Fv0Eeq4HxA/jHrL2BYw==
Received: from daedalus.home (unknown [178.231.9.255])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 88543683-b8b6-11f0-bff1-00505699772e;
	Mon, 03 Nov 2025 14:10:56 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: jkoolstra@xs4all.nl,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com
Subject: [PATCH] Replace BUG_ON with error handling in hfs_new_inode()
Date: Mon,  3 Nov 2025 14:10:10 +0100
Message-ID: <20251103131023.2804655-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.51.1.dirty
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

hfs_new_inode() is the only place were the 32-bit limits need to be
verified, since only in that function can these values be increased.
Therefore, the checks in hfs_mdb_commit() and hfs_delete_inode() are
removed.

Singed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
Reported-by: syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=17cc9bb6d8d69b4139f0
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/hfs/dir.c   |  8 ++++----
 fs/hfs/inode.c | 30 ++++++++++++++++++++++++------
 fs/hfs/mdb.c   |  3 ---
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 86a6b317b474..ee1760305380 100644
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
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 9cd449913dc8..beec6fe7e801 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -186,16 +186,23 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	s64 next_id;
 	s64 file_count;
 	s64 folder_count;
+	int err = -ENOMEM;
 
 	if (!inode)
-		return NULL;
+		goto out_err;
+
+	err = -ENOSPC;
 
 	mutex_init(&HFS_I(inode)->extents_lock);
 	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
 	spin_lock_init(&HFS_I(inode)->open_dir_lock);
 	hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, name);
 	next_id = atomic64_inc_return(&HFS_SB(sb)->next_id);
-	BUG_ON(next_id > U32_MAX);
+	if (next_id > U32_MAX) {
+		pr_err("hfs: next file ID exceeds 32-bit limit — possible "
+		       "superblock corruption");
+		goto out_discard;
+	}
 	inode->i_ino = (u32)next_id;
 	inode->i_mode = mode;
 	inode->i_uid = current_fsuid();
@@ -209,7 +216,11 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	if (S_ISDIR(mode)) {
 		inode->i_size = 2;
 		folder_count = atomic64_inc_return(&HFS_SB(sb)->folder_count);
-		BUG_ON(folder_count > U32_MAX);
+		if (folder_count > U32_MAX) {
+			pr_err("hfs: folder count exceeds 32-bit limit — possible "
+			       "superblock corruption");
+			goto out_discard;
+		}
 		if (dir->i_ino == HFS_ROOT_CNID)
 			HFS_SB(sb)->root_dirs++;
 		inode->i_op = &hfs_dir_inode_operations;
@@ -219,7 +230,11 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	} else if (S_ISREG(mode)) {
 		HFS_I(inode)->clump_blocks = HFS_SB(sb)->clumpablks;
 		file_count = atomic64_inc_return(&HFS_SB(sb)->file_count);
-		BUG_ON(file_count > U32_MAX);
+		if (file_count > U32_MAX) {
+			pr_err("hfs: file count exceeds 32-bit limit — possible "
+			       "superblock corruption");
+			goto out_discard;
+		}
 		if (dir->i_ino == HFS_ROOT_CNID)
 			HFS_SB(sb)->root_files++;
 		inode->i_op = &hfs_file_inode_operations;
@@ -243,6 +258,11 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	hfs_mark_mdb_dirty(sb);
 
 	return inode;
+
+	out_discard:
+		iput(inode);	
+	out_err:
+		return ERR_PTR(err); 
 }
 
 void hfs_delete_inode(struct inode *inode)
@@ -251,7 +271,6 @@ void hfs_delete_inode(struct inode *inode)
 
 	hfs_dbg("ino %lu\n", inode->i_ino);
 	if (S_ISDIR(inode->i_mode)) {
-		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
 		atomic64_dec(&HFS_SB(sb)->folder_count);
 		if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
 			HFS_SB(sb)->root_dirs--;
@@ -260,7 +279,6 @@ void hfs_delete_inode(struct inode *inode)
 		return;
 	}
 
-	BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
 	atomic64_dec(&HFS_SB(sb)->file_count);
 	if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
 		HFS_SB(sb)->root_files--;
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 53f3fae60217..1c3fb631cc8e 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -273,15 +273,12 @@ void hfs_mdb_commit(struct super_block *sb)
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
 
-- 
2.51.1.dirty


